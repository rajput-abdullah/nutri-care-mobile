import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
class CBCClassifier {
  late Interpreter _interpreter;
  late List<String> _labels;

  final int maxLen = 128;

  Future<void> load() async {
    _interpreter = await Interpreter.fromAsset('assets/model/cbc_model.tflite');
    _labels = await _loadLabels();
  }

  Future<List<String>> _loadLabels() async {
    final raw = await rootBundle.loadString('assets/model/cbc_labels.txt');
    return raw.split('\n').where((line) => line.trim().isNotEmpty).toList();
  }

  Future<Map<String, dynamic>> classify(List<List<int>> input) async {
    // Match model output shape
    var output = List.filled(1 * 1, 0.0).reshape([1, 1]);

    try {
      _interpreter.run(input, output);

      final probCBC = output[0][0];
      final predictedLabel = probCBC > 0.5 ? "CBC" : "Not_CBC";
      final confidence = probCBC > 0.5 ? probCBC : 1 - probCBC;

      return {
        "label": predictedLabel,
        "confidence": confidence,
      };
    } catch (e) {
      print("❌ Model inference failed: $e");
      return {
        "label": "Unknown",
        "confidence": 0.0,
      };
    }
  }

}
