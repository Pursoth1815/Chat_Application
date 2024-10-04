import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/features/auth/data/entities/auth_entity.dart';
import 'package:neighborgood/features/home/domain/models/post_feeds_model.dart';
import 'package:neighborgood/features/home/domain/repository/user_profile_post_repo.dart';
import 'package:neighborgood/features/home/presentation/providers/post_feed_provider.dart';

class UserPostRepoImpl implements UserProfilePostRepo {
  final FirebaseFirestore firestore;

  UserPostRepoImpl(this.firestore);

  late final CollectionReference _userPostRef = firestore.collection('neighborgood_feeds').withConverter<PostFeedsModel>(
        fromFirestore: (snapshot, _) => PostFeedsModel.fromMap(snapshot.data()!),
        toFirestore: (userPost_list, _) => userPost_list.toMap(),
      );

  @override
  Stream<QuerySnapshot<Object?>> fetchUserPost(String userId) {
    if (userId.isEmpty) {
      return _userPostRef.snapshots();
    }
    return _userPostRef.where('user_id', isEqualTo: int.parse(userId)).snapshots();
  }

  @override
  Future<AuthResponse> TriggerAction(ActionBtn action, int post_id) async {
    try {
      final query = await firestore.collection('neighborgood_feeds').where("pid", isEqualTo: post_id).get();

      if (query.docs.isEmpty) {
        return AuthResponse(
          status: false,
          message: 'Something went wrong Post deleted.',
        );
      }

      final userDoc = query.docs.first.reference;
      final userDocData = query.docs.first.data();

      if (action == ActionBtn.like) {
        if (userDocData['liked']) {
          await userDoc.update({'liked': false});
        } else {
          await userDoc.update({'liked': true});
        }
      } else {
        if (userDocData['saved']) {
          await userDoc.update({'saved': false});
        } else {
          await userDoc.update({'saved': true});
        }
      }

      return AuthResponse(
        status: true,
        message: '',
      );
    } catch (e) {
      print(e);
      return AuthResponse(
        status: false,
        message: 'Error creating user: $e',
      );
    }
  }
}
