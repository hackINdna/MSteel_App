import "package:flutter/material.dart";
import 'package:m_steel/util/language_constants.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.onChanged,
    required this.controller,
  });
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => setState(() {
        widget.onChanged!(value);
      }),
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: "${transText(context).searchHere}...",
        suffixIcon: (widget.controller.text.isNotEmpty)
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.controller.clear();
                  });
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 17,
                ))
            : null,
        contentPadding: const EdgeInsets.all(0),
        prefixIcon: const Icon(Icons.search, color: Colors.black87),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.black87),
        ),
      ),
    );
  }
}
