import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/create_post/domain/repository/create_post_repo.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';

class CreatePostRepoImpl implements CreatePostRepository {
  final FirebaseFirestore firestore;

  CreatePostRepoImpl(this.firestore);

  @override
  Future<AuthResponse> createPost(PostFeedsModel model) async {
    try {
      final getLastId = await firestore.collection('neighborgood_feeds').orderBy('pid').limitToLast(1).get();

      final userDoc = getLastId.docs.first;
      final lastInsertedID = userDoc.data();

      int PID = int.parse(lastInsertedID['pid'].toString()) + 1;
      PostFeedsModel finalList = model.copyWith(pid: PID);

      await firestore.collection('neighborgood_feeds').add(finalList.toMap());

      return AuthResponse(
        status: true,
        message: 'Post saved successfully.',
      );
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Error creating user: $e',
      );
    }
  }

  @override
  Future<AuthResponse> uploadPostImage(File file) async {
    try {
      String? fileExtension;
      const int maxSizeInBytes = 10 * 1024 * 1024;

      final int fileSize = await file.length();

      if (fileSize > maxSizeInBytes) {
        return AuthResponse(status: false, message: 'File size exceeds 10MB.');
      }
      final mimeType = lookupMimeType(file.path);

      if (mimeType == 'image/jpeg') {
        fileExtension = 'jpg';
      } else if (mimeType == 'image/png') {
        fileExtension = 'png';
      } else {
        return AuthResponse(status: false, message: 'Unsupported file format. Only JPG and PNG are allowed.');
      }

      final storageRef = FirebaseStorage.instance.ref();

      final imageRef = storageRef.child('Post_Attachments/${DateTime.now().millisecondsSinceEpoch}.$fileExtension');

      final uploadTask = imageRef.putFile(file);

      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();

      return AuthResponse(status: true, message: imageUrl);
    } catch (e) {
      return AuthResponse(
        status: false,
        message: 'Error creating post: $e',
      );
    }
  }
}
