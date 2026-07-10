import 'package:flutter/material.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  void _showFeatureToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Scan feature is coming soon. Use the upload button to add an image.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Scan',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.divider, width: 2),
                          borderRadius: BorderRadius.circular(28),
                          color: AppColors.surfaceSoft,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.camera_alt,
                            color: AppColors.textSecondary,
                            size: 72,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Capture a leaf, stem, or flower to diagnose your orchid.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => _showFeatureToast(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          minimumSize: const Size(170, 52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Upload image'),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => _showFeatureToast(context),
                        child: const Text('Use camera'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.flash_off, color: AppColors.white),
                  Icon(Icons.image, color: AppColors.white),
                  Icon(Icons.photo_camera_front, color: AppColors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
