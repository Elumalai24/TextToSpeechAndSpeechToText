import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextWidget extends StatefulWidget {
  SpeechToTextWidget({Key? key}) : super(key: key);

  @override
  _SpeechToTextWidgetState createState() => _SpeechToTextWidgetState();
}

class _SpeechToTextWidgetState extends State<SpeechToTextWidget> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Speech To Text", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'Recognized words:',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.all(16),
            child: Text(
              // If listening is active show the recognized words
              _speechToText.isListening
                  ? '$_lastWords'
              // If listening isn't active but could be tell the user
              // how to start it, otherwise indicate that speech
              // recognition is not yet ready or not supported on
              // the target device
                  : _speechEnabled
                  ? 'Tap the microphone to start listening...'
                  : 'Speech not available',
            ),
          ),
          IconButton(onPressed: _speechToText.isNotListening ? _startListening : _stopListening, icon: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic))
        ],
      ),
    );
  }
}
