import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final void Function(String)? onChanged;
  const MyTextFormField({
    Key? key,
    this.keyboardType,
    this.initialValue,
    this.readOnly,
    this.hintText,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        minLines: 1,
        maxLines: 10,
        onChanged: onChanged,
        initialValue: initialValue,
        keyboardType: keyboardType,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          errorText: errorText,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
