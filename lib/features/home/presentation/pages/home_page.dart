import 'package:flutter/material.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';
import 'package:orchid_vision/features/detection/presentation/pages/scan_page.dart';
import 'package:orchid_vision/features/orchids/presentation/pages/my_orchids_page.dart';
import 'package:orchid_vision/features/profile/presentation/pages/profile_page.dart';
import 'package:orchid_vision/features/settings/presentation/pages/settings_page.dart';
import 'package:orchid_vision/features/orchids/presentation/pages/orchiai_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const MyOrchidsPage(),
    const OrchiAiPage(),
    const ScanPage(),
    const ProfilePage(),
    const SettingsPage(),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: AppColors.scaffoldBackground,
        elevation: 16,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => _onTabSelected(0),
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: _selectedIndex == 0 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              IconButton(
                onPressed: () => _onTabSelected(1),
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: _selectedIndex == 1 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 52),
              IconButton(
                onPressed: () => _onTabSelected(3),
                icon: Icon(
                  Icons.person_outline,
                  color: _selectedIndex == 3 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
              IconButton(
                onPressed: () => _onTabSelected(4),
                icon: Icon(
                  Icons.settings_outlined,
                  color: _selectedIndex == 4 ? AppColors.primary : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTabSelected(2),
        backgroundColor: AppColors.accent,
        child: const Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
