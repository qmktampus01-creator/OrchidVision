import 'package:flutter/material.dart';
import 'package:orchid_vision/app/router/app_routes.dart';
import 'package:orchid_vision/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:orchid_vision/features/auth/presentation/pages/login_page.dart';
import 'package:orchid_vision/features/auth/presentation/pages/signup_page.dart';
import 'package:orchid_vision/features/home/presentation/pages/home_page.dart';
import 'package:orchid_vision/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:orchid_vision/features/profile/presentation/pages/profile_page.dart';
import 'package:orchid_vision/features/settings/presentation/pages/settings_page.dart';
import 'package:orchid_vision/features/splash/presentation/pages/splash_page.dart';
import 'package:orchid_vision/features/orchids/presentation/pages/orchiai_page.dart';
import 'package:orchid_vision/features/detection/presentation/pages/scan_page.dart';
import 'package:orchid_vision/features/orchids/presentation/pages/my_orchids_page.dart';
import 'package:orchid_vision/features/orchids/presentation/pages/orchid_detail_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.myOrchids:
        return MaterialPageRoute(builder: (_) => const MyOrchidsPage());
      case AppRoutes.orchiAi:
        return MaterialPageRoute(builder: (_) => const OrchiAiPage());
      case AppRoutes.scan:
        return MaterialPageRoute(builder: (_) => const ScanPage());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case AppRoutes.orchidDetail:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => OrchidDetailPage(
            name: args['name'] ?? 'Orchid',
            lastScan: args['lastScan'] ?? 'Unknown',
            status: args['status'] ?? 'Unknown',
            recommendation: args['recommendation'] ?? 'No data',
            monitorStatus: args['monitorStatus'] ?? 'No data',
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
