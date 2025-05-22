import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../utils/tts_service.dart';
import '../utils/stt_service.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  String _language = 'en';

  void _sendMessage() async {
    final message = _controller.text;
    final reply = await ApiService.sendToGPT(message, _language);
    setState(() => _response = reply);
    TTSService.speak(reply, _language);
  }

  void _startListening() async {
    final speech = await STTService.listen();
    setState(() => _controller.text = speech);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Airport Chatbot')),
      body: Column(
        children: [
          TextField(controller: _controller),
          Row(
            children: [
              IconButton(onPressed: _startListening, icon: Icon(Icons.mic)),
              IconButton(onPressed: _sendMessage, icon: Icon(Icons.send)),
            ],
          ),
          Expanded(child: SingleChildScrollView(child: Text(_response))),
        ],
      ),
    );
  }
}