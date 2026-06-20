import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight; // Добавили для жирности
  final double lineHeight;     // Добавили для интервалов

  const TextWidget({
    Key? key, 
    required this.text, 
    required this.color, 
    required this.size,
    this.fontWeight = FontWeight.normal, // По умолчанию обычный
    this.lineHeight = 1.2,               // По умолчанию стандартный
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight, // Применяем жирность
        height: lineHeight,     // Применяем интервал
        decoration: TextDecoration.none,
      ),
    );
  }
}
