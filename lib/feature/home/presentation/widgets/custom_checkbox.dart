import 'package:flutter/material.dart';

// Custom Circle Checkbox
class CustomCircleCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onChanged;

  const CustomCircleCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Container(
        height: 24.0,
        width: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isChecked ? Colors.green : Colors.transparent,
          border: Border.all(color: Colors.white),
        ),
        child: isChecked
            ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 16.0,
        )
            : null,
      ),
    );
  }
}
