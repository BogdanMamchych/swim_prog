import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_prog/core/models/user.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/user_list"),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            user.name,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _InfoBlock(title: 'Basic info', children: [
            _InfoRow(label: 'Username', value: user.username),
            _InfoRow(label: 'Email', value: user.email),
            _InfoRow(label: 'Phone', value: user.phone),
            _InfoRow(label: 'Website', value: user.website),
          ]),

          const SizedBox(height: 16),

          _InfoBlock(title: 'Address', children: [
            _InfoRow(label: 'Street', value: user.address.street),
            _InfoRow(label: 'Suite', value: user.address.suite),
            _InfoRow(label: 'City', value: user.address.city),
            _InfoRow(label: 'Zipcode', value: user.address.zipcode),
            _InfoRow(
              label: 'Geo',
              value: '${user.address.geo.lat}, ${user.address.geo.lng}',
            ),
          ]),

          const SizedBox(height: 16),

          _InfoBlock(title: 'Company', children: [
            _InfoRow(label: 'Name', value: user.company.name),
            _InfoRow(label: 'Catch phrase', value: user.company.catchPhrase),
            _InfoRow(label: 'BS', value: user.company.bs),
          ]),
        ],
      ),
    );
  }
}
class _InfoBlock extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _InfoBlock({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}