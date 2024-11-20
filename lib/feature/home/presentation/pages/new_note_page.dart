import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../data/model/notemodel.dart';
import 'home_page.dart';

class NewNotePage extends StatefulWidget {
  final Todos? noteToEdit;  // Optional note to edit, null if it's a new note

  const NewNotePage({super.key, this.noteToEdit});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      _titleController.text = widget.noteToEdit!.todo ?? '';
      _descriptionController.text = widget.noteToEdit!.userId.toString();
    }
  }

  void _saveNewNote() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Create or update Todos object
      Todos newTodo = Todos(
        id: widget.noteToEdit?.id ?? DateTime.now().millisecondsSinceEpoch, // Use existing ID if editing
        todo: _titleController.text,
        completed: widget.noteToEdit?.completed ?? false, // Keep the previous completion state
        userId: int.tryParse(_descriptionController.text) ?? 1,
      );

      var box = await Hive.openBox<NoteModel>('noteBox');
      NoteModel? savedNoteModel = box.get('noteKey');

      if (savedNoteModel == null) {
        savedNoteModel = NoteModel(todos: [], total: 0, skip: 0, limit: 20);
      }

      if (widget.noteToEdit != null) {
        // If editing, replace the existing note
        savedNoteModel.todos![savedNoteModel.todos!.indexWhere((todo) => todo.id == widget.noteToEdit!.id)] = newTodo;
      } else {
        // If it's a new note, add it
        savedNoteModel.todos!.add(newTodo);
      }

      savedNoteModel.total = savedNoteModel.todos!.length;
      await box.put('noteKey', savedNoteModel);

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.noteToEdit == null ? 'New Note' : 'Edit Note'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title TextField
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Note Title',
                  hintText: 'Enter title here...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Description TextField (for example, userId or description)
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'User ID (or Description)',
                  hintText: 'Enter description...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: _saveNewNote,  // Save note to Hive
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                child: Text(
                  widget.noteToEdit == null ? 'Save Note' : 'Update Note',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
