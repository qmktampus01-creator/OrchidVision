import 'package:flutter/material.dart';
import 'package:orchid_vision/app/router/app_routes.dart';
import 'package:orchid_vision/app/theme/app_colors.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Identify your orchids',
      'subtitle': 'Scan leaves and flowers to recognize species and conditions.',
    },
    {
      'title': 'Detect plant issues',
      'subtitle': 'Get AI-powered diagnostics for disease, pests, and stress.',
    },
    {
      'title': 'Save care guidance',
      'subtitle': 'Track health history, notes, and reminders for every plant.',
    },
  ];

  void _goNext() {
    if (_pageIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 80),
                  const Text(
                    'Welcome',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: _skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 360,
                          decoration: BoxDecoration(
                            color: AppColors.surface.withAlpha((0.12 * 255).round()),
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.local_florist,
                              size: 110,
                              color: AppColors.accentLight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          page['title']!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: _pageIndex == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: _pageIndex == index
                              ? AppColors.accent
                              : AppColors.surface.withAlpha((0.32 * 255).round()),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _goNext,
                    child: Text(_pageIndex == _pages.length - 1 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
