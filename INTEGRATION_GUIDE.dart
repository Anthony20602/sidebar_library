/// HOW TO USE THIS LIBRARY IN ANOTHER PROJECT
/// 
/// This file explains step-by-step how to integrate the sidebar library
/// into your existing or new Flutter project.

/// ============================================================================
/// STEP 1: COPY THE LIBRARY
/// ============================================================================
/// 
/// Option A: Copy the entire folder
/// - Copy the `sidebar_library` folder to the same directory as your project
/// - Your structure should look like:
///   workspace/
///   ├── your_project/
///   └── sidebar_library/
///
/// Option B: Copy as a package inside your project
/// - Create a `packages` folder in your project
/// - Copy `sidebar_library` into it
///   your_project/
///   ├── lib/
///   ├── packages/
///   │   └── sidebar_library/
///   └── pubspec.yaml

/// ============================================================================
/// STEP 2: UPDATE YOUR PUBSPEC.YAML
/// ============================================================================
/// 
/// Add the sidebar_library as a dependency in your project's pubspec.yaml:
/// 
/// Option A (if library is in sibling directory):
/// ```yaml
/// dependencies:
///   flutter:
///     sdk: flutter
///   sidebar_library:
///     path: ../sidebar_library
/// ```
///
/// Option B (if library is in packages directory):
/// ```yaml
/// dependencies:
///   flutter:
///     sdk: flutter
///   sidebar_library:
///     path: ./packages/sidebar_library
/// ```

/// ============================================================================
/// STEP 3: RUN FLUTTER PUB GET
/// ============================================================================
/// 
/// In your project directory, run:
/// ```bash
/// flutter pub get
/// ```

/// ============================================================================
/// STEP 4: IMPORT AND USE
/// ============================================================================
/// 
/// In your Dart files, import the library:
/// ```dart
/// import 'package:sidebar_library/sidebar_library.dart';
/// ```

/// ============================================================================
/// STEP 5: BASIC IMPLEMENTATION
/// ============================================================================
/// 
/// Here's a minimal example to get you started:

/*
import 'package:flutter/material.dart';
import 'package:sidebar_library/sidebar_library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SidebarLayout(
        sidebar: ResponsiveSidebar(
          items: [
            SidebarItem(
              id: '1',
              title: 'Home',
              icon: Icons.home,
              onTap: () => print('Home tapped'),
            ),
            SidebarItem(
              id: '2',
              title: 'Settings',
              icon: Icons.settings,
              children: [
                SidebarItem(
                  id: '2.1',
                  title: 'General',
                  onTap: () => print('General tapped'),
                ),
                SidebarItem(
                  id: '2.2',
                  title: 'Privacy',
                  onTap: () => print('Privacy tapped'),
                ),
              ],
            ),
          ],
          theme: SidebarTheme.dark(),
        ),
        content: Center(
          child: Text('Your main content here'),
        ),
      ),
    );
  }
}
*/

/// ============================================================================
/// STEP 6: CUSTOMIZE TO YOUR NEEDS
/// ============================================================================
/// 
/// Customize the sidebar by:
/// 1. Adding your menu items in the `items` list
/// 2. Choosing a theme (dark, light, or custom)
/// 3. Adding header/footer if needed
/// 4. Handling onItemSelected callback
/// 5. Setting selectedItemId to highlight active item
///
/// For more examples, see:
/// - lib/example_usage.dart
/// - lib/advanced_examples.dart
/// - lib/main.dart

/// ============================================================================
/// TROUBLESHOOTING
/// ============================================================================
/// 
/// Issue: "Target of URI doesn't exist"
/// Solution: Make sure the path in pubspec.yaml is correct and run `flutter pub get`
///
/// Issue: Sidebar not showing on mobile
/// Solution: Check that you're using SidebarLayout, not just ResponsiveSidebar alone
///
/// Issue: Items not expanding
/// Solution: Make sure items have the `children` property set
///
/// Issue: Theme not applying
/// Solution: Pass the theme to the ResponsiveSidebar widget's `theme` property

/// ============================================================================
/// COMMON PATTERNS
/// ============================================================================

/// Pattern 1: Load menu from API/JSON
/// ```dart
/// List<SidebarItem> loadMenuFromJson(List<dynamic> json) {
///   return json.map((item) => SidebarItem(
///     id: item['id'],
///     title: item['title'],
///     icon: IconData(item['iconCode'], fontFamily: 'MaterialIcons'),
///     children: item['children'] != null 
///         ? loadMenuFromJson(item['children']) 
///         : null,
///   )).toList();
/// }
/// ```

/// Pattern 2: Navigate on item selection
/// ```dart
/// ResponsiveSidebar(
///   items: items,
///   onItemSelected: (itemId) {
///     switch (itemId) {
///       case 'home':
///         Navigator.pushNamed(context, '/home');
///         break;
///       case 'settings':
///         Navigator.pushNamed(context, '/settings');
///         break;
///     }
///   },
/// )
/// ```

/// Pattern 3: Persist sidebar state
/// ```dart
/// class _MyPageState extends State<MyPage> {
///   String? _selectedItem;
///   
///   @override
///   void initState() {
///     super.initState();
///     _loadSelectedItem();
///   }
///   
///   Future<void> _loadSelectedItem() async {
///     final prefs = await SharedPreferences.getInstance();
///     setState(() {
///       _selectedItem = prefs.getString('selectedItem');
///     });
///   }
///   
///   void _onItemSelected(String itemId) async {
///     final prefs = await SharedPreferences.getInstance();
///     await prefs.setString('selectedItem', itemId);
///     setState(() {
///       _selectedItem = itemId;
///     });
///   }
/// }
/// ```

/// ============================================================================
/// NEED HELP?
/// ============================================================================
/// 
/// 1. Check README.md for complete documentation
/// 2. Review PROJECT_STRUCTURE.md for architecture details
/// 3. Look at example_usage.dart for quick start code
/// 4. Explore advanced_examples.dart for complex scenarios
/// 5. Run the demo app (lib/main.dart) to see all features in action
