//主にユーザーにupdateさせたい要素を含ませる
//followerCountとかを含めないのは、ユーザーが自分で変更できないから
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_update_log.freezed.dart';
part 'user_update_log.g.dart';

@freezed
abstract class UserUpdateLog with _$UserUpdateLog {
  const factory UserUpdateLog({
    //順番がわからなくなるので妥協してupdatedAtは入れる。
    //userのupdateには使用させない
    required dynamic logCreatedAt,
    required Map<String, dynamic> searchToken,
    required String userName,
    required String userImageURL,
    required dynamic userRef,
    required String uid,
  }) = _UserUpdateLog;
  factory UserUpdateLog.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateLogFromJson(json);
}
