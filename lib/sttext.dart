import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Hello {
  late String? message;
  void hello(String? a) async {
    print("In sttext.dart");
    await fetchVoiceMessage(a!);
  }

  Future<void> TexttoSpeech(String command, double rate) async {
    FlutterTts flutterTts = new FlutterTts();
    await flutterTts.setLanguage("en-GB");
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(1);
    await flutterTts.speak(command);
  }

  Future fetchVoiceMessage(String a) async {
    String message = a;
    await TexttoSpeech(message, 0.5);
    return null;
  }
}
