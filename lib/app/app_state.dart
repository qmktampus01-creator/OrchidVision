import 'package:flutter/material.dart';

class AppState {
  AppState._();

  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
  }
}
