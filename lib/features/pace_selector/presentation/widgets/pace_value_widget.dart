import 'package:flutter/material.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class PaceValueWidget extends StatelessWidget {
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final TextEditingController? controller;
  final void Function(String)? action;

  const PaceValueWidget({
    Key? key,
    required this.value,
    required this.onIncrement,
    required this.onDecrement, this.controller, this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 32),
          onPressed: onIncrement,
        ),
        
        TextWidget(
          text: value,
          color: Colors.white,
          size: 90,
          fontWeight: FontWeight.w300,
        ),
        
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32),
          onPressed: onDecrement,
        ),
      ],
    );
  }
}
