import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String? hintText;
  const SearchBar(
      {Key? key, required this.onPressed, this.hintText, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextField(
        onChanged: onChanged,
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
