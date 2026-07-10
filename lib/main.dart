import 'package:flutter/material.dart';
import 'package:orchid_vision/app/app.dart';
import 'package:orchid_vision/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const OrchidVisionApp());
}
