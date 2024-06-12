import 'package:flutter/material.dart';
import 'package:voice_assistant_app/widgets/speech_to_text.dart';
import 'package:voice_assistant_app/widgets/text_to_speech.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Text to Speech & Speech to Text"),),
         body: body(),
      ),
    );
  }
  Widget body(){
    return SingleChildScrollView(
      child: Column(children: [
        SpeechToTextWidget(),
       Padding(
         padding: const EdgeInsets.symmetric(vertical: 10),
         child: Divider(),
       ),
       TextToSpeechWidget(),
      ],),
    );
  }
}
