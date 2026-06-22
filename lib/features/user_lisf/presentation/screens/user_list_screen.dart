import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_prog/features/user_lisf/presentation/widgets/user_search_widget.dart';
import 'package:swim_prog/features/user_lisf/presentation/widgets/user_tile_widget.dart';
import 'package:swim_prog/core/providers/user_provider.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersProvider);
    final query = ref.watch(userSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/pace_selector"),
        ),
      ),
      body: usersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (users) {
          final filteredUsers = users.where((user) {
            return user.name.toLowerCase().contains(query.toLowerCase());
          }).toList();

          return RefreshIndicator(
            onRefresh: () => ref.read(usersProvider.notifier).refreshUsers(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
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
                            return UserTileWidget(
                              user: user,
                              onTap: () => context.go("/user_detail", extra: user),
                            );
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