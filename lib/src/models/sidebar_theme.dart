import 'package:flutter/material.dart';

/// Theme configuration for the sidebar
class SidebarTheme {
  /// Background color of the sidebar
  final Color backgroundColor;

  /// Text style for top-level items
  final TextStyle? itemTextStyle;

  /// Text style for child items
  final TextStyle? childItemTextStyle;

  /// Icon color for items
  final Color? iconColor;

  /// Color when an item is hovered (web) or pressed (mobile)
  final Color? hoverColor;

  /// Color when an item is selected
  final Color? selectedColor;

  /// Text color when an item is selected
  final Color? selectedTextColor;

  /// Padding for each menu item
  final EdgeInsetsGeometry itemPadding;

  /// Indentation for each nesting level
  final double indentationWidth;

  /// Width of the sidebar
  final double sidebarWidth;

  /// Border radius for menu items
  final BorderRadius? itemBorderRadius;

  /// Divider between items
  final bool showDividers;

  /// Divider color
  final Color? dividerColor;

  /// Animation duration for expand/collapse
  final Duration animationDuration;

  /// Badge background color
  final Color? badgeColor;

  /// Badge text style
  final TextStyle? badgeTextStyle;

  const SidebarTheme({
    this.backgroundColor = const Color(0xFF2C3E50),
    this.itemTextStyle,
    this.childItemTextStyle,
    this.iconColor,
    this.hoverColor,
    this.selectedColor,
    this.selectedTextColor,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.indentationWidth = 20.0,
    this.sidebarWidth = 280.0,
    this.itemBorderRadius,
    this.showDividers = false,
    this.dividerColor,
    this.animationDuration = const Duration(milliseconds: 200),
    this.badgeColor,
    this.badgeTextStyle,
  });

  /// Creates a light theme
  factory SidebarTheme.light() {
    return SidebarTheme(
      backgroundColor: Colors.white,
      itemTextStyle: const TextStyle(
        color: Color(0xFF2C3E50),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      childItemTextStyle: const TextStyle(
        color: Color(0xFF546E7A),
        fontSize: 14,
      ),
      iconColor: const Color(0xFF546E7A),
      hoverColor: const Color(0xFFF5F5F5),
      selectedColor: const Color(0xFFE3F2FD),
      selectedTextColor: const Color(0xFF1976D2),
      dividerColor: const Color(0xFFE0E0E0),
      badgeColor: const Color(0xFFFF5252),
      badgeTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Creates a dark theme
  factory SidebarTheme.dark() {
    return const SidebarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      itemTextStyle: TextStyle(
        color: Color(0xFFE0E0E0),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      childItemTextStyle: TextStyle(
        color: Color(0xFFB0B0B0),
        fontSize: 14,
      ),
      iconColor: Color(0xFFB0B0B0),
      hoverColor: Color(0xFF2D2D2D),
      selectedColor: Color(0xFF0D47A1),
      selectedTextColor: Color(0xFFBBDEFB),
      dividerColor: Color(0xFF424242),
      badgeColor: Color(0xFFFF5252),
      badgeTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// Creates a copy of this theme with the specified fields updated
  SidebarTheme copyWith({
    Color? backgroundColor,
    TextStyle? itemTextStyle,
    TextStyle? childItemTextStyle,
    Color? iconColor,
    Color? hoverColor,
    Color? selectedColor,
    Color? selectedTextColor,
    EdgeInsetsGeometry? itemPadding,
    double? indentationWidth,
    double? sidebarWidth,
    BorderRadius? itemBorderRadius,
    bool? showDividers,
    Color? dividerColor,
    Duration? animationDuration,
    Color? badgeColor,
    TextStyle? badgeTextStyle,
  }) {
    return SidebarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      childItemTextStyle: childItemTextStyle ?? this.childItemTextStyle,
      iconColor: iconColor ?? this.iconColor,
      hoverColor: hoverColor ?? this.hoverColor,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      itemPadding: itemPadding ?? this.itemPadding,
      indentationWidth: indentationWidth ?? this.indentationWidth,
      sidebarWidth: sidebarWidth ?? this.sidebarWidth,
      itemBorderRadius: itemBorderRadius ?? this.itemBorderRadius,
      showDividers: showDividers ?? this.showDividers,
      dividerColor: dividerColor ?? this.dividerColor,
      animationDuration: animationDuration ?? this.animationDuration,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextStyle: badgeTextStyle ?? this.badgeTextStyle,
    );
  }
}
