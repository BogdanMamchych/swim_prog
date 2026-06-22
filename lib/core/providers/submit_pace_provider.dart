import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swim_prog/core/repositories/user_repository.dart';

final submitPaceProvider =
    AsyncNotifierProvider<SubmitPaceNotifier, void>(
  SubmitPaceNotifier.new,
);

class SubmitPaceNotifier extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.watch(userRepositoryProvider);
  }

  Future<void> submit(double paceSeconds) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _repository.postPace(paceSeconds));
  }

  String messageFor(Object error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          return 'No internet connection';
        case DioExceptionType.badResponse:
          return 'Server error: ${error.response?.statusCode ?? ''}';
        case DioExceptionType.cancel:
          return 'Request was cancelled';
        case DioExceptionType.badCertificate:
          return 'Invalid certificate';
        case DioExceptionType.unknown:
          return 'Failed to complete the request';
      }
    }
    return 'Something went wrong';
  }
}