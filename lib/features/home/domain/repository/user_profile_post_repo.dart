import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/home/presentation/providers/post_feed_provider.dart';

abstract class UserProfilePostRepo {
  Stream<QuerySnapshot> fetchUserPost(String userId);
  Future<AuthResponse> TriggerAction(ActionBtn action, int post_id);
}
