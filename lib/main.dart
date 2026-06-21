import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/features/pace_selector/presentation/screen/pace_selector_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PaceSelectorScreen(),
      ),
    ),
  );
}