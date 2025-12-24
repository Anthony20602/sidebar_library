import 'package:flutter/material.dart';

/// Represents a single item in the sidebar menu with support for unlimited nesting levels.
class SidebarItem {
  /// The unique identifier for this sidebar item
  final String id;

  /// The title text to display for this item
  final String title;

  /// Optional icon to display before the title
  final IconData? icon;

  /// Optional callback when this item is tapped
  final VoidCallback? onTap;

  /// List of child items (subcategories) for this item
  final List<SidebarItem>? children;

  /// Whether this item is initially expanded (only relevant if it has children)
  final bool initiallyExpanded;

  /// Optional custom data that can be attached to this item
  final dynamic data;

  /// Optional badge text to display on the right side (e.g., "New", "5", etc.)
  final String? badge;

  const SidebarItem({
    required this.id,
    required this.title,
    this.icon,
    this.onTap,
    this.children,
    this.initiallyExpanded = false,
    this.data,
    this.badge,
  });

  /// Returns true if this item has children (subcategories)
  bool get hasChildren => children != null && children!.isNotEmpty;

  /// Creates a copy of this item with the specified fields updated
  SidebarItem copyWith({
    String? id,
    String? title,
    IconData? icon,
    VoidCallback? onTap,
    List<SidebarItem>? children,
    bool? initiallyExpanded,
    dynamic data,
    String? badge,
  }) {
    return SidebarItem(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      onTap: onTap ?? this.onTap,
      children: children ?? this.children,
      initiallyExpanded: initiallyExpanded ?? this.initiallyExpanded,
      data: data ?? this.data,
      badge: badge ?? this.badge,
    );
  }
}
