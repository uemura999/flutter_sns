import 'package:freezed_annotation/freezed_annotation.dart';

part 'follower.freezed.dart';
part 'follower.g.dart';

@freezed
abstract class Follower with _$Follower {
  //DBに保存する
  //createdAtやIdが必要
  //自分がフォローしたことの印
  const factory Follower({
    required dynamic createdAt,
    required String followedUid,
    required String followerUid,
  }) = _Follower;
  factory Follower.fromJson(Map<String, dynamic> json) =>
      _$FollowerFromJson(json);
}
