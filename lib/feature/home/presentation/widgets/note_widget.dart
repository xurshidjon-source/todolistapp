import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({super.key});

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16,),  // Added left/right padding for better spacing
      child: Container(
        width: double.infinity,  // Full width for the container

        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),  // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,  // Align the checkbox and text at the top
              children: [
                // Checkbox with a slightly larger size for better visibility
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isChecked ? Colors.yellow : Colors.white, // Border color
                      width: 1.0,  // Border width
                    ),
        ),
                  child: ClipOval(
                    clipBehavior: Clip.hardEdge,
                    child: Material(
                      color:  Colors.black, // Color when checked
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isChecked = !_isChecked;
                          });
                        },
                        child: SizedBox(
                          width: 30.0, // Circular size
                          height: 30.0, // Circular size
                          child: _isChecked
                              ? const Icon(
                            Icons.check,
                            color: Colors.yellow,
                            size: 20.0,
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8,),
                // Expanded widget for the text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text for the checked/unchecked status
                      Text(
                        _isChecked ? 'Checked' : 'Unchecked',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      // Main long text with justification
                      const Text(
                        "The Dart language is type safe; it uses static type checking to ensure that a variable's value always matches the variable's static type. Sometimes, this is referred to as sound typing. Although types are mandatory, type annotations are optional.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),  // Add some spacing between text
                      const Text(
                        "12.12.2024",  // Date or any other additional info
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white54,  // Lighter color for the date
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.white38,
            ),
          ],
        ),
      ),
    );
  }
}
