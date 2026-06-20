import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget{
  final TextEditingController? controller;
  final void Function(String)? action;
  const TextFieldWidget({super.key, required this.controller, this.action});
  

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(),
      onChanged: action,
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(),
      ),
    );
  }
}