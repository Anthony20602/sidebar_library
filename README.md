# Sidebar Library

A responsive, multi-level sidebar library for Flutter applications that works seamlessly on both web and mobile platforms.

## Features

✅ **Unlimited Nesting Levels** - Create categories, subcategories, sub-subcategories, and beyond  
✅ **Responsive Design** - Automatically adapts to mobile (drawer) and desktop (fixed sidebar) layouts  
✅ **Expandable/Collapsible Items** - Smooth animations for expanding nested menus  
✅ **Fully Customizable** - Light/dark themes with extensive styling options  
✅ **Icon Support** - Add icons to any menu item  
✅ **Badge Support** - Display badges for notifications or counts  
✅ **Selection Tracking** - Track and highlight selected items  
✅ **Callbacks** - Handle item taps with custom actions  

## Installation

Add this library to your Flutter project's `pubspec.yaml`:

```yaml
dependencies:
  sidebar_library:
    path: ../sidebar_library  # Adjust path as needed
```

Or if using from the same project:

```dart
import 'package:sidebar_library/sidebar_library.dart';
```

## Usage

### Basic Example

```dart
import 'package:flutter/material.dart';
import 'package:sidebar_library/sidebar_library.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SidebarLayout(
          sidebar: ResponsiveSidebar(
            items: [
              SidebarItem(
                id: '1',
                title: 'Item 1',
                icon: Icons.home,
                children: [
                  SidebarItem(
                    id: '1.1',
                    title: 'Item 1.1',
                    onTap: () => print('Item 1.1 tapped'),
                  ),
                ],
              ),
            ],
          ),
          content: Center(child: Text('Your content here')),
        ),
      ),
    );
  }
}
```

### Multi-Level Nesting

```dart
final items = [
  SidebarItem(
    id: '1',
    title: 'Item 1',
    icon: Icons.dashboard,
    children: [
      SidebarItem(
        id: '1.1',
        title: 'Item 1.1',
        children: [
          SidebarItem(
            id: '1.1.a',
            title: 'Item 1.1.a',
            children: [
              SidebarItem(
                id: '1.1.a.i',
                title: 'Item 1.1.a.i',
                onTap: () => print('Deep nesting!'),
              ),
            ],
          ),
        ],
      ),
    ],
  ),
];
```

### Custom Theming

```dart
ResponsiveSidebar(
  items: items,
  theme: SidebarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    itemTextStyle: TextStyle(color: Colors.white, fontSize: 15),
    selectedColor: Colors.blue,
    iconColor: Colors.white70,
    indentationWidth: 20.0,
    sidebarWidth: 280.0,
  ),
)
```

Or use predefined themes:

```dart
// Dark theme
ResponsiveSidebar(
  items: items,
  theme: SidebarTheme.dark(),
)

// Light theme
ResponsiveSidebar(
  items: items,
  theme: SidebarTheme.light(),
)
```

### With Header and Footer

```dart
ResponsiveSidebar(
  items: items,
  header: Container(
    padding: EdgeInsets.all(20),
    child: Column(
      children: [
        CircleAvatar(child: Icon(Icons.person)),
        SizedBox(height: 10),
        Text('John Doe'),
      ],
    ),
  ),
  footer: Container(
    padding: EdgeInsets.all(16),
    child: Text('Version 1.0.0'),
  ),
)
```

### Track Selection

```dart
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? selectedItemId;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebar(
      items: items,
      selectedItemId: selectedItemId,
      onItemSelected: (itemId) {
        setState(() {
          selectedItemId = itemId;
        });
        print('Selected: $itemId');
      },
    );
  }
}
```

### Add Badges

```dart
SidebarItem(
  id: '1',
  title: 'Notifications',
  icon: Icons.notifications,
  badge: '5',  // Shows a red badge with "5"
)

SidebarItem(
  id: '2',
  title: 'New Feature',
  icon: Icons.star,
  badge: 'New',  // Shows a badge with "New"
)
```

## API Reference

### SidebarItem

| Property | Type | Description |
|----------|------|-------------|
| `id` | `String` | Unique identifier for the item |
| `title` | `String` | Display text |
| `icon` | `IconData?` | Optional icon |
| `onTap` | `VoidCallback?` | Callback when item is tapped |
| `children` | `List<SidebarItem>?` | Nested child items |
| `initiallyExpanded` | `bool` | Whether to start expanded (default: false) |
| `badge` | `String?` | Optional badge text |
| `data` | `dynamic` | Custom data to attach to item |

### ResponsiveSidebar

| Property | Type | Description |
|----------|------|-------------|
| `items` | `List<SidebarItem>` | Top-level sidebar items |
| `theme` | `SidebarTheme?` | Theme configuration |
| `header` | `Widget?` | Header widget |
| `footer` | `Widget?` | Footer widget |
| `selectedItemId` | `String?` | Currently selected item ID |
| `onItemSelected` | `Function(String)?` | Selection callback |
| `mobileBreakpoint` | `double` | Width below which mobile layout is used (default: 768) |

### SidebarTheme

| Property | Type | Default |
|----------|------|---------|
| `backgroundColor` | `Color` | `Color(0xFF2C3E50)` |
| `itemTextStyle` | `TextStyle?` | - |
| `selectedColor` | `Color?` | - |
| `iconColor` | `Color?` | - |
| `sidebarWidth` | `double` | 280.0 |
| `indentationWidth` | `double` | 20.0 |
| `itemPadding` | `EdgeInsets` | `EdgeInsets.symmetric(h: 16, v: 12)` |
| `badgeColor` | `Color?` | - |

### SidebarLayout

| Property | Type | Description |
|----------|------|-------------|
| `sidebar` | `ResponsiveSidebar` | The sidebar widget |
| `content` | `Widget` | Main content area |
| `sidebarOnRight` | `bool` | Position sidebar on right (default: false) |

## How to Use in Another Project

1. **Copy the library**: Copy the entire `sidebar_library` folder to your workspace

2. **Add dependency** in your project's `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     sidebar_library:
       path: ../sidebar_library  # Adjust path relative to your project
   ```

3. **Import and use**:
   ```dart
   import 'package:sidebar_library/sidebar_library.dart';
   ```

## Responsive Behavior

- **Desktop/Web (width ≥ 768px)**: Sidebar is fixed and always visible
- **Mobile (width < 768px)**: Sidebar appears as a drawer that can be toggled
- Custom breakpoint can be set via `mobileBreakpoint` property

## Examples

Check `lib/main.dart` for a comprehensive example showing:
- Multi-level nesting (up to 4 levels deep)
- Light and dark themes
- Icons and badges
- Header and footer
- Selection tracking
- Responsive layout

## License

This project is available for use in any Flutter project.

## Contributing

Feel free to customize and extend this library for your needs!

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
