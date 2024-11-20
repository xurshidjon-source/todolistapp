import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolistapp/feature/home/presentation/widgets/custom_checkbox.dart';

import '../../data/model/notemodel.dart';
import '../pages/new_note_page.dart';

class NoteWidget extends StatelessWidget {
  final NoteModel noteModel;
  final int index;
  final VoidCallback onNoteUpdated;

  const NoteWidget({
    super.key,
    required this.noteModel,
    required this.index,
    required this.onNoteUpdated,
  });

  @override
  Widget build(BuildContext context) {
    Todos todo = noteModel.todos![index];

    void _deleteNote() async {
      var box = await Hive.openBox<NoteModel>('noteBox');
      NoteModel? savedNoteModel = box.get('noteKey');

      if (savedNoteModel != null) {
        savedNoteModel.todos!.removeAt(index);
        savedNoteModel.total = savedNoteModel.todos?.length ?? 0;
        await box.put('noteKey', savedNoteModel);

        onNoteUpdated();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Note deleted')));
      }
    }

    void _editNote() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewNotePage(
            noteToEdit: todo,
          ),
        ),
      ).then((_) {
        onNoteUpdated();
      });
    }

    void _toggleCompletionStatus() async {
      var box = await Hive.openBox<NoteModel>('noteBox');
      NoteModel? savedNoteModel = box.get('noteKey');

      if (savedNoteModel != null) {
        todo.completed = !(todo.completed ?? false);
        await box.put('noteKey', savedNoteModel);

        onNoteUpdated();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(todo.completed == true ? 'Note marked as completed' : 'Note marked as incomplete'),
        ));
      }
    }

    void _showNoteOptions() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose Action"),
            content: const Text("Do you want to delete, edit, or mark this note as completed?"),
            actions: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _deleteNote();
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _editNote();
                    },
                    child: const Text('Edit', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),

            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: _showNoteOptions,
      child: Card(
        color: Colors.grey[850],
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: CustomCircleCheckbox(isChecked: todo.completed ?? false, onChanged:(value){
                  _toggleCompletionStatus();
                }),
              ),
              ListTile(
                title: Text(todo.todo ?? '', style: const TextStyle(color: Colors.white)),
                subtitle: Text('Completed: ${todo.completed == true ? 'Yes' : 'No'}', style: const TextStyle(color: Colors.white60)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}