import 'dart:convert';

import 'package:flutter/services.dart';

class Tokenizer {
  final Map<String, int> vocab;

  Tokenizer(this.vocab);

  List<int> encode(String text, int maxLen) {
    final words = text.toLowerCase().split(RegExp(r'\s+'));
    final tokens = words.map((word) => vocab[word] ?? vocab['<OOV>'] ?? 0).toList();

    if (tokens.length > maxLen) {
      return tokens.sublist(0, maxLen);
    } else {
      return tokens + List.filled(maxLen - tokens.length, 0);
    }
  }
}
class CBCWordIndex {
  Map<String, int> wordIndex = {};

  Future<void> loadWordIndex() async {
    final jsonString = await rootBundle.loadString('assets/model/cbc_word_index.json');
    wordIndex = Map<String, int>.from(json.decode(jsonString));
  }

  List<int> textToSequence(String text, {int maxLen = 50}) {
    final words = text.toLowerCase().split(' ');
    final seq = words.map((w) => wordIndex[w] ?? wordIndex['<OOV>'] ?? 0).toList();

    // Pad or truncate to maxLen
    if (seq.length > maxLen) {
      return seq.sublist(0, maxLen);
    } else {
      return seq + List.filled(maxLen - seq.length, 0);
    }
  }
}
