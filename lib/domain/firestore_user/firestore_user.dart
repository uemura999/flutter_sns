import 'package:freezed_annotation/freezed_annotation.dart';

part 'firestore_user.freezed.dart';
part 'firestore_user.g.dart';

@freezed
abstract class FirestoreUser with _$FirestoreUser {
  const factory FirestoreUser({
    required dynamic createdAt,
    required int followerCount,
    required int followingCount,
    required bool isAdmin,
    required int muteCount,
    required dynamic updatedAt,
    required String userName,
    required String userImageURL,
    required String uid,
  }) = _FirestoreUser;
  factory FirestoreUser.fromJson(Map<String, dynamic> json) =>
      _$FirestoreUserFromJson(json);
}
