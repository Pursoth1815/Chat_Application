import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/auth/data/repository/auth_repository_impl.dart';
import 'package:neighborgood/features/auth/domain/models/register_user_model.dart';
import 'package:neighborgood/features/auth/domain/usecases/sigin_in_usecase.dart';
import 'package:neighborgood/features/auth/domain/usecases/sign_up_usecase.dart';

final pageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});

final userRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(FirebaseFirestore.instance);
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return SignInUseCase(userRepository);
});

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return SignUpUseCase(userRepository);
});

final authStateProvider = StateNotifierProvider<AuthNotifier, void>((ref) {
  final signInUseCase = ref.watch(signInUseCaseProvider);
  final signUpUseCase = ref.watch(signUpUseCaseProvider);
  return AuthNotifier(signInUseCase, signUpUseCase);
});

class AuthNotifier extends StateNotifier<void> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthNotifier(this.signInUseCase, this.signUpUseCase) : super(null);

  Future<AuthResponse> signIn(String username, String password) async {
    try {
      return await signInUseCase.call(username, password);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> signUp(RegisterUserModel model) async {
    try {
      return await signUpUseCase.call(model);
    } catch (e) {
      rethrow;
    }
  }
}
