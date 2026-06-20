import 'package:flutter/material.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_value_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class PaceWidget extends StatefulWidget {
  const PaceWidget({Key? key}) : super(key: key);

  @override
  State<PaceWidget> createState() => _PaceWidgetState();
}

class _PaceWidgetState extends State<PaceWidget> {
  late int minutes = 4;
  late int seconds = 0;
  final TextEditingController _minutesController = TextEditingController();
  final TextEditingController _secondsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaceValueWidget(
          value: "$minutes",
          onIncrement: () => setState(() {
            if (minutes < 9) minutes++;
          }),
          onDecrement: () => setState(() {
            if (minutes > 0) minutes--;
          }),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: TextWidget(
            text: ":",
            color: Color(0xFF00A86B),
            size: 72,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Вторая колонка — Секунды
        PaceValueWidget(
          value: seconds.toString().padLeft(2, '0'),
          onIncrement: () => setState(() {
            if (seconds < 59) {
              seconds += 1;
            } else {
              seconds = 0;
              minutes += 1;
            }
          }),
          onDecrement: () => setState(() {
            if (seconds > 0) {
              seconds -= 1;
            } else {
              seconds = 59;
              minutes -= 1;
            }
          }),
        ),
      ],
    );
  }
}
