import 'package:speech_to_text/speech_to_text.dart' as stt;

class STTService {
  static final stt.SpeechToText _speech = stt.SpeechToText();

  static Future<String> listen() async {
    bool available = await _speech.initialize();
    if (available) {
      await _speech.listen(onResult: (result) {
        if (result.finalResult) {
          _speech.stop();
        }
      });
      await Future.delayed(Duration(seconds: 3));
      await _speech.stop();
      return _speech.lastRecognizedWords;
    } else {
      return "Speech not available";
    }
  }
}
