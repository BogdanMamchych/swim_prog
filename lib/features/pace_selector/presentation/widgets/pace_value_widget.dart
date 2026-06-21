import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaceValueWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final ValueChanged<String> onChanged;
  final int maxLength;

  const PaceValueWidget({
    super.key,
    required this.controller,
    required this.onIncrement,
    required this.onDecrement,
    required this.onChanged,
    this.maxLength = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
            size: 32,
          ),
          onPressed: onIncrement,
        ),
        SizedBox(
          width: 110,
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(maxLength),
            ],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 90,
              fontWeight: FontWeight.w300,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white,
            size: 32,
          ),
          onPressed: onDecrement,
        ),
      ],
    );
  }
}