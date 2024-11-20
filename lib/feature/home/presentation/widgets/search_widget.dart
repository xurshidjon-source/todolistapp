import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchTextChanged;
  final VoidCallback onStartListening;

  const SearchWidget({
    Key? key,
    required this.controller,
    required this.onSearchTextChanged,
    required this.onStartListening,
  }) : super(key: key);

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
              controller: controller,  // Use the single TextEditingController
              onChanged: onSearchTextChanged,  // Call the callback when text changes
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: controller.text.isEmpty
                    ? const Icon(Icons.search, color: Colors.white38, size: 22)
                    : null,  // Show search icon when text is empty
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white38),
                border: InputBorder.none,
              ),
            ),
          ),
          // IconButton for the microphone
          IconButton(
            icon: Icon(
              Icons.mic,
              size: 22,
              color: Colors.grey,
            ),
            onPressed: onStartListening,  // Call the speech-to-text function
          ),
        ],
      ),
    );
  }
}
