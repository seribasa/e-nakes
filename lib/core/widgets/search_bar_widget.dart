import 'package:flutter/material.dart';

import '../utils/debouncer.dart';

class SearchBarPeltops extends StatelessWidget {
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String? hintText;
  const SearchBarPeltops(
      {super.key, required this.onPressed, this.hintText, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final debouncer = Debouncer(milliseconds: 500);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
        onChanged: onChanged != null
            ? (value) {
                debouncer.run(() {
                  onChanged!(value);
                });
              }
            : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
