import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/core/providers/user_provider.dart';

class UserSearchWidget extends ConsumerWidget {
  const UserSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search by name',
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        ref.read(userSearchQueryProvider.notifier).state = value;
      },
    );
  }
}