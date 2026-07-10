import 'package:tflite_flutter/tflite_flutter.dart';

class TFLiteService {
  late final Interpreter interpreter;

  Future<void> loadModel(String modelPath) async {
    interpreter = await Interpreter.fromAsset(modelPath);
  }
}
