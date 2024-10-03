// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostFeedsModel {
  int pid;
  int user_id;
  String title;
  String description;
  String post_image_path;
  bool saved;
  bool liked;
  PostFeedsModel({
    required this.pid,
    required this.user_id,
    required this.title,
    required this.description,
    required this.post_image_path,
    this.saved = false,
    this.liked = false,
  });

  PostFeedsModel copyWith({
    int? pid,
    int? user_id,
    String? title,
    String? description,
    String? post_image_path,
    bool? saved,
    bool? liked,
  }) {
    return PostFeedsModel(
      pid: pid ?? this.pid,
      user_id: user_id ?? this.user_id,
      title: title ?? this.title,
      description: description ?? this.description,
      post_image_path: post_image_path ?? this.post_image_path,
      saved: saved ?? this.saved,
      liked: liked ?? this.liked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pid': pid,
      'user_id': user_id,
      'title': title,
      'description': description,
      'post_image_path': post_image_path,
      'saved': saved,
      'liked': liked,
    };
  }

  factory PostFeedsModel.fromMap(Map<String, dynamic> map) {
    return PostFeedsModel(
      pid: map['pid'] as int,
      user_id: map['user_id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      post_image_path: map['post_image_path'] as String,
      saved: map['saved'] as bool,
      liked: map['liked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory PostFeedsModel.fromJson(String source) => PostFeedsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PostFeedsModel(pid: $pid, user_id: $user_id, title: $title, description: $description, post_image_path: $post_image_path, saved: $saved, liked: $liked)';
  }

  @override
  bool operator ==(covariant PostFeedsModel other) {
    if (identical(this, other)) return true;

    return other.pid == pid &&
        other.user_id == user_id &&
        other.title == title &&
        other.description == description &&
        other.post_image_path == post_image_path &&
        other.saved == saved &&
        other.liked == liked;
  }

  @override
  int get hashCode {
    return pid.hashCode ^ user_id.hashCode ^ title.hashCode ^ description.hashCode ^ post_image_path.hashCode ^ saved.hashCode ^ liked.hashCode;
  }
}
