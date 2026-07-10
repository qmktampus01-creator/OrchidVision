import 'package:flutter/material.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';
import 'package:orchid_vision/app/app_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  bool _criticalAlerts = false;
  String _displayMode = 'Light';

  void _setDisplayMode(String mode) {
    setState(() {
      _displayMode = mode;
    });
    switch (mode) {
      case 'Light':
        AppState.setThemeMode(ThemeMode.light);
        break;
      case 'Dark':
        AppState.setThemeMode(ThemeMode.dark);
        break;
      default:
        AppState.setThemeMode(ThemeMode.system);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched display mode to $mode.')),
    );
  }

  void _handleAction(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                _sectionCard(
                  title: 'Notifications',
                  child: Column(
                    children: [
                      _toggleRow('Email Notifications', _emailNotifications, (value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      }),
                      _toggleRow('Push Notifications', _pushNotifications, (value) {
                        setState(() {
                          _pushNotifications = value;
                        });
                      }),
                      _toggleRow('Critical Alerts', _criticalAlerts, (value) {
                        setState(() {
                          _criticalAlerts = value;
                        });
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _sectionCard(
                  title: 'Display Settings',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _modeButton('Light'),
                      const SizedBox(width: 10),
                      _modeButton('Dark'),
                      const SizedBox(width: 10),
                      _modeButton('Auto'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _sectionCard(
                  title: 'Security & Privacy',
                  child: Column(
                    children: [
                      _infoRow('Change password', '••••••••'),
                      const SizedBox(height: 12),
                      _infoRow('Two-Factor Authentication', 'Enabled'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _handleAction('Scan history cleared.'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger,
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('Clear scan history'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _handleAction('Cache cleared.'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.danger,
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: const Text('Clear cache'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _toggleRow(String label, bool value, void Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _modeButton(String label) {
    final bool isSelected = _displayMode == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => _setDisplayMode(label),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.accent : AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? AppColors.accent : AppColors.divider,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
