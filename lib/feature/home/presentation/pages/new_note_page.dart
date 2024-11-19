import 'package:flutter/material.dart';
import 'package:todolistapp/commons/route/app_route.dart';
import 'package:todolistapp/feature/home/presentation/pages/home_page.dart';

class NewNotePage extends StatefulWidget {
  const NewNotePage({super.key});

  @override
  State<NewNotePage> createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _titlecontroller.clear();
    _descriptioncontroller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("New Note", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Title TextField
              TextFormField(
                controller: _titlecontroller,
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

              // Description TextField
              TextFormField(
                controller: _descriptioncontroller,
                decoration: InputDecoration(
                  labelText: 'Note Description',
                  hintText: 'Enter description here...',
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

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Show the note details in a dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Note Title", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(_titlecontroller.text, style: TextStyle(color: Colors.indigoAccent)),
                                SizedBox(height: 10),
                                Text("Note Description", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text(_descriptioncontroller.text, style: TextStyle(color: Colors.indigoAccent)),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);

                                    }, child: Text("Cancel", style: TextStyle(color: Colors.red),)),
                                    TextButton(onPressed: (){
                                      AppRoute().navigateTo(context, HomePage());

                                    }, child: Text("Save", style: TextStyle(color: Colors.indigo),))
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigoAccent)),
                child: Text("Submit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
