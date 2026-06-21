import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/core/repositories/user_repository.dart';
import 'package:swim_prog/features/user_lisf/presentation/widgets/user_search_widget.dart';
import 'package:swim_prog/features/user_lisf/presentation/widgets/user_tile_widget.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    final query = ref.watch(userSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
        data: (users) {
          final filteredUsers = users.where((user) {
            return user.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return RefreshIndicator(
            onRefresh: () => ref.read(usersProvider.notifier).refreshUsers(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: UserSearchWidget(),
                ),
                Expanded(
                  child: filteredUsers.isEmpty
                      ? const Center(child: Text('No users found'))
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: filteredUsers.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            return UserTileWidget(user: user, onTap: () {});
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}