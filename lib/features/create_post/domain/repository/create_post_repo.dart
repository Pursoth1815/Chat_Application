import 'dart:io';

import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';

abstract class CreatePostRepository {
  Future<AuthResponse> createPost(PostFeedsModel post);
  Future<AuthResponse> uploadPostImage(File file);
}
