import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/data/providers/pace_providers.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/pace_value_widget.dart';
import 'package:swim_prog/features/pace_selector/presentation/widgets/text_widget.dart';

class PaceWidget extends ConsumerStatefulWidget {
  const PaceWidget({super.key});

  @override
  ConsumerState<PaceWidget> createState() => _PaceWidgetState();
}

class _PaceWidgetState extends ConsumerState<PaceWidget> {
  late final TextEditingController _minutesController;
  late final TextEditingController _secondsController;

  @override
  void initState() {
    super.initState();

    final duration = ref.read(paceProvider);

    _minutesController = TextEditingController(
      text: duration.inMinutes.toString(),
    );

    _secondsController = TextEditingController(
      text: (duration.inSeconds % 60).toString().padLeft(2, '0'),
    );
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = ref.watch(paceProvider);

    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;

    _minutesController.text = minutes.toString();
    _secondsController.text = seconds.toString().padLeft(2, '0');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PaceValueWidget(
          controller: _minutesController,
          onIncrement: () {
            ref.read(paceProvider.notifier).incrementMinutes();
          },
          onDecrement: () {
            ref.read(paceProvider.notifier).decrementMinutes();
          },
          onChanged: (value) {
            final parsed = int.tryParse(value);

            if (parsed != null) {
              ref.read(paceProvider.notifier).setDuration(
                Duration(
                  minutes: parsed,
                  seconds: seconds,
                ),
              );
            }
          },
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: TextWidget(
            text: ":",
            color: Color(0xFF00A86B),
            size: 72,
            fontWeight: FontWeight.bold,
          ),
        ),

        PaceValueWidget(
          controller: _secondsController,
          onIncrement: () {
            ref.read(paceProvider.notifier).incrementSeconds();
          },
          onDecrement: () {
            ref.read(paceProvider.notifier).decrementSeconds();
          },
          onChanged: (value) {
            final parsed = int.tryParse(value);

            if (parsed != null) {
              ref.read(paceProvider.notifier).setDuration(
                Duration(
                  minutes: minutes,
                  seconds: parsed,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}