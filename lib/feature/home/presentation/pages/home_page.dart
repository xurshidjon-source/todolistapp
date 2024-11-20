import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../../data/model/notemodel.dart';
import '../widgets/note_widget.dart';
import '../widgets/search_widget.dart';
import 'new_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  NoteModel? noteModel;
  List<Todos> filteredTodos = [];
  late TextEditingController searchController;
  stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _fetchSavedData();
    _initializeSpeech();
  }

  void _fetchSavedData() async {
    var box = await Hive.openBox<NoteModel>('noteBox');
    NoteModel? savedNoteModel = box.get('noteKey');
    setState(() {
      noteModel = savedNoteModel;
      filteredTodos = savedNoteModel?.todos ?? [];
      isLoading = false;
    });
  }

  void _initializeSpeech() async {
    bool available = await _speech.initialize();
    if (available) {
      setState(() {
        isListening = true;
      });
    }
  }

  void _refreshNotes() {
    setState(() {
      _fetchSavedData(); // Re-fetch the notes from Hive to update the UI
    });
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredTodos = noteModel?.todos?.where((todo) {
        return todo.todo?.toLowerCase().contains(text.toLowerCase()) ?? false;
      }).toList() ?? [];
    });
  }

  void _startListening() async {
    if (!_speech.isListening) {
      await _speech.listen(onResult: (result) {
        setState(() {
          searchController.text = result.recognizedWords;
          _onSearchTextChanged(searchController.text); // Update search on speech result
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigoAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewNotePage()),
          ).then((_) {
            _refreshNotes(); // Refresh notes when coming back from the NewNotePage
          });
        },
        child: const Text("Add", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "ЗАДАЧИ",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 34),
                ),
              ),
              const SizedBox(height: 10),
              // Integrating SearchWidget
              SearchWidget(
                controller: searchController,
                onSearchTextChanged: _onSearchTextChanged, // Pass the callback for search text
                onStartListening: _startListening, // Pass the callback for voice search
              ),
              SizedBox(height: 20,),
              // Show loading spinner or the list of notes
              isLoading
                  ? const Center(child: CircularProgressIndicator()) // Loading indicator
                  : Expanded(
                child: ListView.builder(
                  itemCount: filteredTodos.length,
                  itemBuilder: (context, index) {
                    return NoteWidget(
                      noteModel: noteModel!,
                      index: index,
                      onNoteUpdated: _refreshNotes, // Pass the callback for UI refresh
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
