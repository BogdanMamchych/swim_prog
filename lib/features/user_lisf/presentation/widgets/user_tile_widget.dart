import 'package:flutter/material.dart';
import 'package:swim_prog/core/models/user.dart';

class UserTileWidget extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserTileWidget({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.email),
          Text(user.phone),
        ],
      ),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}