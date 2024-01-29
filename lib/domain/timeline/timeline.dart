import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline.freezed.dart';
part 'timeline.g.dart';

@freezed
abstract class Timeline with _$Timeline {
  //DBに保存する
  //createdAtやIdが必要
  //自分がフォローしたことの印
  const factory Timeline({
    required dynamic createdAt,
    //フォロワーが投稿を読み込んだかどうか
    required bool isRead,
    required String postCreatorUid,
    required String postId,
  }) = _Timeline;
  factory Timeline.fromJson(Map<String, dynamic> json) =>
      _$TimelineFromJson(json);
}
