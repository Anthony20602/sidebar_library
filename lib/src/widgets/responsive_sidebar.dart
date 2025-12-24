import 'package:flutter/material.dart';
import '../models/sidebar_item.dart';
import '../models/sidebar_theme.dart';
import 'sidebar_menu_item.dart';

/// A responsive sidebar widget that adapts to mobile and web layouts
/// Supports unlimited nesting levels of menu items
class ResponsiveSidebar extends StatefulWidget {
  /// List of top-level sidebar items
  final List<SidebarItem> items;

  /// Theme configuration for the sidebar
  final SidebarTheme? theme;

  /// Header widget to display at the top of the sidebar (e.g., logo, title)
  final Widget? header;

  /// Footer widget to display at the bottom of the sidebar
  final Widget? footer;

  /// Whether the sidebar is initially visible on mobile
  final bool initiallyVisibleOnMobile;

  /// Callback when the selected item changes
  final Function(String itemId)? onItemSelected;

  /// Callback when sidebar visibility changes (mobile only)
  final Function(bool isVisible)? onSidebarVisibilityChanged;

  /// The currently selected item ID
  final String? selectedItemId;

  /// Whether to show a toggle button on mobile
  final bool showToggleButton;

  /// Custom toggle button widget
  final Widget? customToggleButton;

  /// Breakpoint width below which mobile layout is used
  final double mobileBreakpoint;

  const ResponsiveSidebar({
    super.key,
    required this.items,
    this.theme,
    this.header,
    this.footer,
    this.initiallyVisibleOnMobile = false,
    this.onItemSelected,
    this.onSidebarVisibilityChanged,
    this.selectedItemId,
    this.showToggleButton = true,
    this.customToggleButton,
    this.mobileBreakpoint = 768,
  });

  @override
  State<ResponsiveSidebar> createState() => _ResponsiveSidebarState();
}

class _ResponsiveSidebarState extends State<ResponsiveSidebar> {
  late bool _isVisible;
  String? _internalSelectedItemId;

  @override
  void initState() {
    super.initState();
    _isVisible = widget.initiallyVisibleOnMobile;
    _internalSelectedItemId = widget.selectedItemId;
  }

  @override
  void didUpdateWidget(ResponsiveSidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItemId != oldWidget.selectedItemId) {
      setState(() {
        _internalSelectedItemId = widget.selectedItemId;
      });
    }
    if (widget.initiallyVisibleOnMobile != oldWidget.initiallyVisibleOnMobile) {
      setState(() {
        _isVisible = widget.initiallyVisibleOnMobile;
      });
    }
  }

  void _toggleSidebar() {
    setState(() {
      _isVisible = !_isVisible;
    });
    if (widget.onSidebarVisibilityChanged != null) {
      widget.onSidebarVisibilityChanged!(_isVisible);
    }
  }

  void _handleItemSelected(String itemId, {bool hasChildren = false}) {
    setState(() {
      _internalSelectedItemId = itemId;
    });
    
    if (widget.onItemSelected != null) {
      widget.onItemSelected!(itemId);
    }

    // On mobile, close sidebar only when selecting a leaf item (no children)
    // This allows parent items to expand/collapse without closing the sidebar
    if (_isMobile(context) && !hasChildren) {
      setState(() {
        _isVisible = false;
      });
      if (widget.onSidebarVisibilityChanged != null) {
        widget.onSidebarVisibilityChanged!(false);
      }
    }
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < widget.mobileBreakpoint;
  }

  Widget _buildSidebarContent(SidebarTheme theme) {
    return Container(
      width: theme.sidebarWidth,
      color: theme.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          if (widget.header != null) widget.header!,

          // Menu items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: widget.items
                  .map((item) => SidebarMenuItem(
                        item: item,
                        theme: theme,
                        level: 0,
                        selectedItemId: _internalSelectedItemId,
                        onItemSelected: _handleItemSelected,
                      ))
                  .toList(),
            ),
          ),

          // Footer
          if (widget.footer != null) widget.footer!,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? SidebarTheme.dark();
    final isMobile = _isMobile(context);

    return isMobile
        ? _buildMobileLayout(theme)
        : _buildDesktopLayout(theme);
  }

  Widget _buildDesktopLayout(SidebarTheme theme) {
    return _buildSidebarContent(theme);
  }

  Widget _buildMobileLayout(SidebarTheme theme) {
    return Stack(
      children: [
        // Overlay
        if (_isVisible)
          GestureDetector(
            onTap: _toggleSidebar,
            child: Container(
              color: Colors.black54,
            ),
          ),

        // Sidebar drawer
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          left: _isVisible ? 0 : -theme.sidebarWidth,
          top: 0,
          bottom: 0,
          width: theme.sidebarWidth,
          child: Material(
            elevation: 16,
            child: _buildSidebarContent(theme),
          ),
        ),

        // Toggle button
        if (widget.showToggleButton && !_isVisible)
          Positioned(
            top: 16,
            left: 16,
            child: widget.customToggleButton ??
                FloatingActionButton(
                  mini: true,
                  onPressed: _toggleSidebar,
                  child: const Icon(Icons.menu),
                ),
          ),
      ],
    );
  }
}

/// A builder widget that provides the sidebar and content area
/// Use this for a complete page layout with sidebar
class SidebarLayout extends StatelessWidget {
  /// The sidebar widget
  final ResponsiveSidebar sidebar;

  /// The main content widget
  final Widget content;

  /// Whether to show the sidebar on the right side (default is left)
  final bool sidebarOnRight;

  const SidebarLayout({
    super.key,
    required this.sidebar,
    required this.content,
    this.sidebarOnRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 
        (sidebar.mobileBreakpoint);

    if (isMobile) {
      return Stack(
        children: [
          content,
          sidebar,
        ],
      );
    }

    return Row(
      children: sidebarOnRight
          ? [
              Expanded(child: content),
              sidebar,
            ]
          : [
              sidebar,
              Expanded(child: content),
            ],
    );
  }
}
