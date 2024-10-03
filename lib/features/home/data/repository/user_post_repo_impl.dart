import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:neighborgood/features/create_post/domain/models/create_post_model.dart';
import 'package:neighborgood/features/home/domain/repository/user_profile_post_repo.dart';

class UserPostRepoImpl implements UserProfilePostRepo {
  final FirebaseFirestore firestore;

  UserPostRepoImpl(this.firestore);

  late final CollectionReference _userPostRef = firestore.collection('neighborgood_feeds').withConverter<CreatePostModel>(
        fromFirestore: (snapshot, _) => CreatePostModel.fromMap(snapshot.data()!),
        toFirestore: (userPost_list, _) => userPost_list.toMap(),
      );

  @override
  Stream<QuerySnapshot<Object?>> fetchUserPost(String userId) {
    return _userPostRef.where('user_id', isEqualTo: userId).snapshots();
  }
}
