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
      title: 'Sidebar Library Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SidebarDemo(),
    );
  }
}

class SidebarDemo extends StatefulWidget {
  const SidebarDemo({super.key});

  @override
  State<SidebarDemo> createState() => _SidebarDemoState();
}

class _SidebarDemoState extends State<SidebarDemo> {
  String? _selectedItemId;
  bool _useDarkTheme = true;
  bool _isSidebarVisible = false;

  // Create sample data with multi-level nesting
  List<SidebarItem> _getSidebarItems() {
    return [
      SidebarItem(
        id: '1',
        title: 'Item 1',
        icon: Icons.dashboard,
        children: [
          SidebarItem(
            id: '1.1',
            title: 'Item 1.1',
            icon: Icons.folder,
            children: [
              SidebarItem(
                id: '1.1.a',
                title: 'Item 1.1.a',
                icon: Icons.article,
                onTap: () => _showSnackBar('Selected: Item 1.1.a'),
              ),
              SidebarItem(
                id: '1.1.b',
                title: 'Item 1.1.b',
                icon: Icons.article,
                badge: 'New',
                onTap: () => _showSnackBar('Selected: Item 1.1.b'),
              ),
              SidebarItem(
                id: '1.1.c',
                title: 'Item 1.1.c',
                icon: Icons.article,
                onTap: () => _showSnackBar('Selected: Item 1.1.c'),
              ),
            ],
          ),
          SidebarItem(
            id: '1.2',
            title: 'Item 1.2',
            icon: Icons.folder,
            badge: '5',
            children: [
              SidebarItem(
                id: '1.2.a',
                title: 'Item 1.2.a',
                icon: Icons.article,
                onTap: () => _showSnackBar('Selected: Item 1.2.a'),
              ),
              SidebarItem(
                id: '1.2.b',
                title: 'Item 1.2.b',
                icon: Icons.article,
                children: [
                  SidebarItem(
                    id: '1.2.b.i',
                    title: 'Item 1.2.b.i',
                    icon: Icons.insert_drive_file,
                    onTap: () => _showSnackBar('Selected: Item 1.2.b.i'),
                  ),
                  SidebarItem(
                    id: '1.2.b.ii',
                    title: 'Item 1.2.b.ii',
                    icon: Icons.insert_drive_file,
                    onTap: () => _showSnackBar('Selected: Item 1.2.b.ii'),
                  ),
                ],
              ),
            ],
          ),
          SidebarItem(
            id: '1.3',
            title: 'Item 1.3',
            icon: Icons.folder,
            onTap: () => _showSnackBar('Selected: Item 1.3'),
          ),
        ],
      ),
      SidebarItem(
        id: '2',
        title: 'Item 2',
        icon: Icons.settings,
        children: [
          SidebarItem(
            id: '2.1',
            title: 'Item 2.1',
            icon: Icons.tune,
            onTap: () => _showSnackBar('Selected: Item 2.1'),
          ),
          SidebarItem(
            id: '2.2',
            title: 'Item 2.2',
            icon: Icons.tune,
            children: [
              SidebarItem(
                id: '2.2.a',
                title: 'Item 2.2.a',
                icon: Icons.settings_applications,
                onTap: () => _showSnackBar('Selected: Item 2.2.a'),
              ),
              SidebarItem(
                id: '2.2.b',
                title: 'Item 2.2.b',
                icon: Icons.settings_applications,
                onTap: () => _showSnackBar('Selected: Item 2.2.b'),
              ),
            ],
          ),
        ],
      ),
      SidebarItem(
        id: '3',
        title: 'Item 3',
        icon: Icons.people,
        children: [
          SidebarItem(
            id: '3.1',
            title: 'Item 3.1',
            icon: Icons.person,
            onTap: () => _showSnackBar('Selected: Item 3.1'),
          ),
          SidebarItem(
            id: '3.2',
            title: 'Item 3.2',
            icon: Icons.person,
            onTap: () => _showSnackBar('Selected: Item 3.2'),
          ),
          SidebarItem(
            id: '3.3',
            title: 'Item 3.3',
            icon: Icons.person,
            onTap: () => _showSnackBar('Selected: Item 3.3'),
          ),
        ],
      ),
      SidebarItem(
        id: '4',
        title: 'Item 4',
        icon: Icons.analytics,
        badge: '12',
        onTap: () => _showSnackBar('Selected: Item 4'),
      ),
      SidebarItem(
        id: '5',
        title: 'Item 5',
        icon: Icons.help,
        onTap: () => _showSnackBar('Selected: Item 5'),
      ),
    ];
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SidebarLayout(
        sidebar: ResponsiveSidebar(
          items: _getSidebarItems(),
          theme: _useDarkTheme ? SidebarTheme.dark() : SidebarTheme.light(),
          selectedItemId: _selectedItemId,
          initiallyVisibleOnMobile: _isSidebarVisible,
          showToggleButton: false,
          onItemSelected: (itemId) {
            setState(() {
              _selectedItemId = itemId;
            });
          },
          onSidebarVisibilityChanged: (isVisible) {
            setState(() {
              _isSidebarVisible = isVisible;
            });
          },
          header: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _useDarkTheme
                  ? Colors.black.withOpacity(0.2)
                  : Colors.blue.withOpacity(0.1),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue,
                  child: const Icon(
                    Icons.apps,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Sidebar Library',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _useDarkTheme ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Multi-level Navigation',
                  style: TextStyle(
                    fontSize: 12,
                    color: _useDarkTheme ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          footer: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _useDarkTheme
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: _useDarkTheme ? Colors.white70 : Colors.black54,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: _useDarkTheme ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        content: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          // App Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Menu button for mobile
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = MediaQuery.of(context).size.width < 768;
                    if (isMobile) {
                      return IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: _toggleSidebar,
                        tooltip: 'Toggle Menu',
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const Expanded(
                  child: Text(
                    'Sidebar Library Demo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _useDarkTheme = !_useDarkTheme;
                    });
                  },
                  icon: Icon(_useDarkTheme ? Icons.light_mode : Icons.dark_mode),
                  label: Text(_useDarkTheme ? 'Light Theme' : 'Dark Theme'),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(
                    'Multi-Level Navigation',
                    'This sidebar supports unlimited nesting levels. Try expanding Item 1 → Item 1.1 → Item 1.1.a to see deeply nested items.',
                    Icons.account_tree,
                    Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    'Responsive Design',
                    'Resize your browser window to see the sidebar transform into a mobile drawer on smaller screens.',
                    Icons.devices,
                    Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    'Customizable',
                    'Switch between light and dark themes using the button above. You can customize colors, fonts, spacing, and more.',
                    Icons.palette,
                    Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  _buildInfoCard(
                    'Feature-Rich',
                    'Includes icons, badges, selection tracking, smooth animations, and callbacks for item selection.',
                    Icons.star,
                    Colors.purple,
                  ),
                  const SizedBox(height: 24),
                  if (_selectedItemId != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle, color: Colors.blue),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Currently selected: $_selectedItemId',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String description, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
