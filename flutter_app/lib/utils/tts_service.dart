import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  static final _tts = FlutterTts();

  static Future<void> speak(String text, String lang) async {
    await _tts.setLanguage(lang);
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }
}
