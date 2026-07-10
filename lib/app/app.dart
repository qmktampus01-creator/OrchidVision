import 'package:flutter/material.dart';
import 'package:orchid_vision/app/router/app_router.dart';
import 'package:orchid_vision/app/router/app_routes.dart';
import 'package:orchid_vision/app/app_state.dart';
import 'package:orchid_vision/app/theme/app_theme.dart';

class OrchidVisionApp extends StatelessWidget {
  const OrchidVisionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppState.themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'OrchidVision',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}
