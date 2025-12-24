/// A responsive, multi-level sidebar library for Flutter applications
/// 
/// This library provides a fully customizable sidebar widget that works
/// seamlessly across web and mobile platforms with support for unlimited
/// nesting levels of menu items.
///
/// ## Features
/// - Unlimited nesting levels (categories, subcategories, sub-subcategories, etc.)
/// - Responsive design (drawer on mobile, fixed sidebar on desktop)
/// - Expandable/collapsible menu items
/// - Customizable theming
/// - Icon support
/// - Badge support
/// - Selection tracking
/// - Smooth animations
///
/// ## Usage
/// ```dart
/// import 'package:sidebar_library/sidebar_library.dart';
///
/// final items = [
///   SidebarItem(
///     id: '1',
///     title: 'Item 1',
///     icon: Icons.home,
///     children: [
///       SidebarItem(
///         id: '1.1',
///         title: 'Item 1.1',
///         children: [
///           SidebarItem(id: '1.1.a', title: 'Item 1.1.a'),
///         ],
///       ),
///     ],
///   ),
/// ];
///
/// SidebarLayout(
///   sidebar: ResponsiveSidebar(
///     items: items,
///     theme: SidebarTheme.light(),
///   ),
///   content: YourContentWidget(),
/// );
/// ```
library sidebar_library;

// Models
export 'src/models/sidebar_item.dart';
export 'src/models/sidebar_theme.dart';

// Widgets
export 'src/widgets/responsive_sidebar.dart';
export 'src/widgets/sidebar_menu_item.dart';
