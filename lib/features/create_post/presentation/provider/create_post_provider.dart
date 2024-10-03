import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/data/repository/create_post_repo_impl.dart';
import 'package:neighborgood/features/create_post/domain/usecases/create_post_usecase.dart';
import 'package:neighborgood/features/create_post/domain/usecases/upload_file_usecase.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';

class CreatePostProvider extends StateNotifier<void> {
  final CreatePostUseCase createPostUseCase;
  final UploadFileUsecase uploadFileUseCase;

  CreatePostProvider(this.createPostUseCase, this.uploadFileUseCase) : super(null);

  Future<AuthResponse> uploadPost(PostFeedsModel post) async {
    try {
      return await createPostUseCase.call(post);
    } catch (e) {
      rethrow;
    }
  }

  Future<AuthResponse> uploadFile(File file) async {
    try {
      return await uploadFileUseCase.call(file);
    } catch (e) {
      rethrow;
    }
  }
}

final postRepositoryProvider = Provider<CreatePostRepoImpl>((ref) {
  return CreatePostRepoImpl(FirebaseFirestore.instance);
});

final createPostUseCaseProvider = Provider<CreatePostUseCase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  return CreatePostUseCase(postRepository);
});

final uploadFileUseCaseProvider = Provider<UploadFileUsecase>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  return UploadFileUsecase(postRepository);
});

final createPostStateProvider = StateNotifierProvider<CreatePostProvider, void>((ref) {
  final createPostUseCase = ref.watch(createPostUseCaseProvider);
  final uploadFileUseCase = ref.watch(uploadFileUseCaseProvider);
  return CreatePostProvider(createPostUseCase, uploadFileUseCase);
});

final fileProvider = StateProvider<File?>((ref) => null);
