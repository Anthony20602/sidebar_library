import 'package:flutter/material.dart';
import '../models/sidebar_item.dart';
import '../models/sidebar_theme.dart';

/// A single menu item widget that supports expansion for nested children
class SidebarMenuItem extends StatefulWidget {
  final SidebarItem item;
  final SidebarTheme theme;
  final int level;
  final String? selectedItemId;
  final Function(String itemId, {bool hasChildren}) onItemSelected;

  const SidebarMenuItem({
    super.key,
    required this.item,
    required this.theme,
    required this.level,
    required this.selectedItemId,
    required this.onItemSelected,
  });

  @override
  State<SidebarMenuItem> createState() => _SidebarMenuItemState();
}

class _SidebarMenuItemState extends State<SidebarMenuItem>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.item.initiallyExpanded;
  }

  void _handleTap() {
    if (widget.item.hasChildren) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
    
    widget.onItemSelected(widget.item.id, hasChildren: widget.item.hasChildren);
    
    if (widget.item.onTap != null) {
      widget.item.onTap!();
    }
  }

  Color _getBackgroundColor() {
    final isSelected = widget.selectedItemId == widget.item.id;
    
    if (isSelected) {
      return widget.theme.selectedColor ?? Colors.blue.withOpacity(0.2);
    }
    
    if (_isHovered) {
      return widget.theme.hoverColor ?? Colors.grey.withOpacity(0.1);
    }
    
    return Colors.transparent;
  }

  Color _getTextColor() {
    final isSelected = widget.selectedItemId == widget.item.id;
    
    if (isSelected && widget.theme.selectedTextColor != null) {
      return widget.theme.selectedTextColor!;
    }
    
    if (widget.level == 0) {
      return widget.theme.itemTextStyle?.color ?? Colors.white;
    }
    
    return widget.theme.childItemTextStyle?.color ?? Colors.white70;
  }

  TextStyle _getTextStyle() {
    final baseStyle = widget.level == 0
        ? widget.theme.itemTextStyle
        : widget.theme.childItemTextStyle;
    
    return (baseStyle ?? const TextStyle()).copyWith(
      color: _getTextColor(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final indentation = widget.level * widget.theme.indentationWidth;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _handleTap,
              hoverColor: widget.theme.hoverColor,
              borderRadius: widget.theme.itemBorderRadius,
              child: Container(
                padding: widget.theme.itemPadding,
                margin: EdgeInsets.only(left: indentation),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  borderRadius: widget.theme.itemBorderRadius,
                ),
                child: Row(
                  children: [
                    // Icon
                    if (widget.item.icon != null) ...[
                      Icon(
                        widget.item.icon,
                        size: 20,
                        color: _getTextColor(),
                      ),
                      const SizedBox(width: 12),
                    ],
                    
                    // Title
                    Expanded(
                      child: Text(
                        widget.item.title,
                        style: _getTextStyle(),
                      ),
                    ),
                    
                    // Badge
                    if (widget.item.badge != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: widget.theme.badgeColor ?? Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.item.badge!,
                          style: widget.theme.badgeTextStyle ??
                              const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                    
                    // Expansion indicator
                    if (widget.item.hasChildren) ...[
                      const SizedBox(width: 8),
                      AnimatedRotation(
                        turns: _isExpanded ? 0.25 : 0,
                        duration: widget.theme.animationDuration,
                        child: Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: _getTextColor(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        
        // Divider
        if (widget.theme.showDividers && widget.level == 0)
          Divider(
            color: widget.theme.dividerColor,
            height: 1,
            thickness: 1,
            indent: indentation,
          ),
        
        // Children
        AnimatedSize(
          duration: widget.theme.animationDuration,
          curve: Curves.easeInOut,
          child: _isExpanded && widget.item.hasChildren
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: widget.item.children!
                      .map((child) => SidebarMenuItem(
                            item: child,
                            theme: widget.theme,
                            level: widget.level + 1,
                            selectedItemId: widget.selectedItemId,
                            onItemSelected: widget.onItemSelected,
                          ))
                      .toList(),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
