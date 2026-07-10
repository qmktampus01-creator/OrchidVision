import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class YoloService {
  late Interpreter _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('models/yolov8.tflite');
  }

  TensorImage preprocess(Uint8List imageBytes) {
    final image = img.decodeImage(imageBytes);
    if (image == null) {
      throw ArgumentError('Unable to decode input image bytes.');
    }

    final input = TensorImage.fromImage(image);
    final processor = ImageProcessorBuilder()
        .add(ResizeOp(640, 640, ResizeMethod.BILINEAR))
        .build();
    return processor.process(input);
  }

  List<dynamic> predict(TensorImage input) {
    final outputShapes = _interpreter.getOutputTensors().map((t) => t.shape).toList();
    final outputs = <int, Object>{};
    for (var i = 0; i < outputShapes.length; i++) {
      outputs[i] = TensorBuffer.createFixedSize(outputShapes[i], TfLiteType.float32);
    }
    _interpreter.runForMultipleInputs([input.buffer], outputs);
    return outputs.values.toList();
  }
}
