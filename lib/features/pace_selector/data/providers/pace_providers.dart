import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final paceConfigProvider = Provider<PaceConfig>((ref) {
  return const PaceConfig(
    minTime: Duration(seconds: 40),
    maxTime: Duration(minutes: 3, seconds: 20),
    marks: const <SkillMark> [
        SkillMark(skill: "Elite", color: const Color(0xFF00C853), startTime: Duration(seconds: 40), endTime: Duration(minutes: 1, seconds: 15)),
        SkillMark(skill: "Advanced", color: const Color(0xFF64DD17), startTime: Duration(minutes: 1, seconds: 15), endTime: Duration(minutes: 1, seconds: 45)),
        SkillMark(skill: "Intermediate", color: const Color(0xFFFFD600), startTime: Duration(minutes: 1, seconds: 45), endTime: Duration(minutes: 2, seconds: 30)),
        SkillMark(skill: "Beginner", color: const Color(0xFFFF6D00), startTime: Duration(minutes: 2, seconds: 30), endTime: Duration(minutes: 3, seconds: 20)),
    ],
    defaultTime: Duration(seconds: 50),
  );
});

final paceProvider = NotifierProvider<PaceNotifier, Duration>(PaceNotifier.new);

final paceLengthProvider = Provider<int>((ref) {
  final config = ref.watch(paceConfigProvider);
  return (config.maxTime - config.minTime).inSeconds;
});

final tickMarksProvider = Provider<List<double>>((ref) {
  final config = ref.watch(paceConfigProvider);
  return config.marks
      .map((mark) => mark.startTime.inSeconds.toDouble())
      .toList();
});

final colorsProvider = Provider<List<Color>>((ref) {
  final config = ref.watch(paceConfigProvider);
  return config.marks
  .map((mark) => mark.color)
  .toList();
});

class PaceNotifier extends Notifier<Duration> {
  @override
  Duration build() {
    return ref.read(paceConfigProvider).defaultTime;
  }

  void incrementMinutes() {
    final max = ref.read(paceConfigProvider).maxTime;

    final next = state + const Duration(minutes: 1);

    if (next <= max) {
      state = next;
    }
  }

  void decrementMinutes() {
    final min = ref.read(paceConfigProvider).minTime;

    final next = state - const Duration(minutes: 1);

    if (next >= min) {
      state = next;
    }
  }

  void incrementSeconds() {
    final max = ref.read(paceConfigProvider).maxTime;

    final next = state + const Duration(seconds: 1);

    if (next <= max) {
      state = next;
    }
  }

  void decrementSeconds() {
    final min = ref.read(paceConfigProvider).minTime;

    final next = state - const Duration(seconds: 1);

    if (next >= min) {
      state = next;
    }
  }

  void setDuration(Duration duration) {
    final config = ref.read(paceConfigProvider);

    if (duration < config.minTime) {
      state = config.minTime;
    } else if (duration > config.maxTime) {
      state = config.maxTime;
    } else {
      state = duration;
    }
  }
}

class PaceConfig {
  final Duration minTime;
  final Duration maxTime;
  final List<SkillMark> marks;
  final Duration defaultTime;

  const PaceConfig({
    required this.minTime,
    required this.maxTime,
    required this.marks,
    required this.defaultTime,
  });
}

class SkillMark {
  final String skill;
  final Color color;
  final Duration startTime;
  final Duration endTime;

  const SkillMark({
    required this.skill,
    required this.color,
    required this.startTime,
    required this.endTime,
  });
}
