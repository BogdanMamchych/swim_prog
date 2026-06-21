import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:swim_prog/core/models/user.dart';
import 'package:swim_prog/core/providers/users_provider.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio);

  Future<List<User>> getUsers() async {
    final response = await dio.get('/users');
    final data = response.data as List<dynamic>;

    return data
        .cast<Map<String, dynamic>>()
        .map(User.fromJson)
        .toList();
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(dioProvider));
});

final usersProvider =
    AsyncNotifierProvider<UsersNotifier, List<User>>(UsersNotifier.new);

class UsersNotifier extends AsyncNotifier<List<User>> {
  late final UserRepository _repository;

  @override
  Future<List<User>> build() async {
    _repository = ref.watch(userRepositoryProvider);
    return _repository.getUsers();
  }

  Future<void> refreshUsers() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.getUsers());
  }
}

final userSearchQueryProvider = StateProvider<String>((ref) => '');