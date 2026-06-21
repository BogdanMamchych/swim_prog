import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:swim_prog/core/models/user.dart';
import 'package:swim_prog/features/pace_selector/presentation/screen/pace_selector_screen.dart';
import 'package:swim_prog/features/user_lisf/presentation/screens/user_detail_screen.dart';
import 'package:swim_prog/features/user_lisf/presentation/screens/user_list_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/pace_selector",
    routes: [
      GoRoute(
        path: "/pace_selector",
        builder: (context, state) => const PaceSelectorScreen(),
      ),
      GoRoute(
        path: "/user_list",
        builder: (context, state) => const UserListScreen(),
      ),
      GoRoute(
        path: "/user_detail",
        builder: (context, state) {
          final User user = state.extra as User;
          return UserDetailScreen(user: user);
        },
      )
    ],
  );
});
