// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final String text;
  final TextEditingController textEditingController;
  const TextFieldInput({
    Key? key,
    required this.text,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
      ),
    );
  }
}
