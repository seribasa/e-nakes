import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String? initialValue;
  final TextInputType? keyboardType;
  const MyTextFormField({Key? key, this.keyboardType, this.initialValue})
      : super(key: key);

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
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
