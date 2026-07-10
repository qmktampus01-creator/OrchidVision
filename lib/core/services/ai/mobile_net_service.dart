import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class MobileNetService {
  late Interpreter _interpreter;
  late TensorImage _inputImage;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('models/mobilenet_v3.tflite');
  }

  TensorImage preprocess(Uint8List imageBytes) {
    final image = img.decodeImage(imageBytes);
    if (image == null) {
      throw ArgumentError('Unable to decode input image bytes.');
    }

    final input = TensorImage.fromImage(image);
    final processor = ImageProcessorBuilder()
        .add(ResizeOp(224, 224, ResizeMethod.BILINEAR))
        .build();
    _inputImage = processor.process(input);
    return _inputImage;
  }

  List<double> predict(TensorImage input) {
    final output = TensorBuffer.createFixedSize(<int>[1, 1001], TfLiteType.float32);
    _interpreter.run(input.buffer, output.buffer);
    return output.getDoubleList();
  }
}
