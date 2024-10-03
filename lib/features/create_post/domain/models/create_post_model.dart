import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostModel {
  int user_id;
  String title;
  String description;
  String post_image_path;
  bool saved;

  CreatePostModel({
    this.user_id = 0,
    this.saved = false,
    required this.title,
    required this.description,
    required this.post_image_path,
  });

  CreatePostModel copyWith({
    int? user_id,
    bool? saved,
    String? title,
    String? description,
    DateTime? created_at,
    String? post_image_path,
  }) {
    return CreatePostModel(
      user_id: user_id ?? this.user_id,
      saved: saved ?? this.saved,
      title: title ?? this.title,
      description: description ?? this.description,
      post_image_path: post_image_path ?? this.post_image_path,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'created_at': FieldValue.serverTimestamp(),
      'post_image_path': post_image_path,
      'user_id': user_id,
      'saved': saved,
    };
  }

  factory CreatePostModel.fromMap(Map<String, dynamic> map) {
    return CreatePostModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      post_image_path: map['post_image_path'] ?? '',
      user_id: map['user_id'] ?? '',
      saved: map['saved'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostModel.fromJson(String source) => CreatePostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreatePostModel(title: $title, description: $description, post_image_path: $post_image_path)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePostModel &&
        other.user_id == user_id &&
        other.saved == saved &&
        other.title == title &&
        other.description == description &&
        other.post_image_path == post_image_path;
  }

  @override
  int get hashCode {
    return saved.hashCode ^ user_id.hashCode ^ title.hashCode ^ description.hashCode ^ post_image_path.hashCode;
  }
}
