import 'package:flutter/material.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';

class MyOrchidsPage extends StatelessWidget {
  const MyOrchidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Orchids',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statusCard('4', 'Registered', AppColors.white),
                  _statusCard('2', 'Healthy', AppColors.success),
                  _statusCard('2', 'Diseased', AppColors.danger),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: 4,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final isHealthy = index % 2 == 0;
                    final orchidName = 'Waling-Waling #${index + 1}';
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/orchid-detail',
                          arguments: {
                            'name': orchidName,
                            'lastScan': 'Jun ${5 + index}, 2025',
                            'status': isHealthy ? 'Healthy' : 'Diseased',
                            'recommendation': isHealthy
                                ? 'Continue regular watering and provide balanced fertilizer. Monitor humidity and keep leaves dry.'
                                : 'Remove affected tissue, apply a copper-based fungicide, and increase airflow around the plant.',
                            'monitorStatus': isHealthy
                                ? 'Stable growth with regular leaf checks.'
                                : 'Needs daily inspection for fungal progress and humidity control.',
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: AppColors.primaryLight,
                              ),
                              child: const Icon(
                                Icons.local_florist,
                                color: AppColors.white,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    orchidName,
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Last scan: Jun ${5 + index}, 2025',
                                    style: const TextStyle(
                                      color: AppColors.textSecondary,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: isHealthy
                                    ? AppColors.success.withAlpha((0.12 * 255).round())
                                    : AppColors.danger.withAlpha((0.12 * 255).round()),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                isHealthy ? 'Healthy' : 'Diseased',
                                style: TextStyle(
                                  color: isHealthy ? AppColors.success : AppColors.danger,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
