import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late stt.SpeechToText _speech;  // Speech-to-text instance
  bool _isListening = false;  // Flag to track if speech recognition is active
  late TextEditingController _controller;  // Controller for the TextField

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();  // Initialize speech-to-text instance
    _controller = TextEditingController();  // Initialize text editing controller
  }

  // Start or stop speech recognition
  void _toggleListening() async {
    if (_isListening) {
      setState(() {
        _isListening = false;
      });
      _speech.stop();  // Stop listening when the user taps the mic button
    } else {
      bool available = await _speech.initialize();  // Initialize speech-to-text
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;  // Update TextField with recognized text
            });
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16.0, left: 3),
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          // Expanded widget for the TextField
          Expanded(
            child: TextField(
              controller: _controller,  // Use the single TextEditingController
              onChanged: (text) {
                setState(() {
                  // When the user starts typing, the search icon will disappear
                });
              },
              style: TextStyle(color: Colors.white),  // Set text color to black or any other color
              decoration: InputDecoration(

                prefixIcon: _controller.text.isEmpty
                    ? Icon(Icons.search, color: Colors.white38, size: 22,)  // Show search icon when text is empty
                    : null,  // Hide the icon when there's text in the field
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white38),
                border: InputBorder.none,

              ),
            ),
          ),
          // IconButton for the microphone
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none, size: 22,  // Change the icon based on listening state
              color: _isListening ? Colors.blue : Colors.grey,
            ),
            onPressed: _toggleListening,  // Toggle speech-to-text listening state
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();  // Dispose of the controller when the widget is disposed
    super.dispose();
  }
}
