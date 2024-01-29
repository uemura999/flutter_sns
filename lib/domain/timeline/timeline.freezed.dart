// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timeline.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Timeline _$TimelineFromJson(Map<String, dynamic> json) {
  return _Timeline.fromJson(json);
}

/// @nodoc
mixin _$Timeline {
  dynamic get createdAt =>
      throw _privateConstructorUsedError; //フォロワーが投稿を読み込んだかどうか
  bool get isRead => throw _privateConstructorUsedError;
  String get postCreatorUid => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimelineCopyWith<Timeline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimelineCopyWith<$Res> {
  factory $TimelineCopyWith(Timeline value, $Res Function(Timeline) then) =
      _$TimelineCopyWithImpl<$Res, Timeline>;
  @useResult
  $Res call(
      {dynamic createdAt, bool isRead, String postCreatorUid, String postId});
}

/// @nodoc
class _$TimelineCopyWithImpl<$Res, $Val extends Timeline>
    implements $TimelineCopyWith<$Res> {
  _$TimelineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? isRead = null,
    Object? postCreatorUid = null,
    Object? postId = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimelineImplCopyWith<$Res>
    implements $TimelineCopyWith<$Res> {
  factory _$$TimelineImplCopyWith(
          _$TimelineImpl value, $Res Function(_$TimelineImpl) then) =
      __$$TimelineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt, bool isRead, String postCreatorUid, String postId});
}

/// @nodoc
class __$$TimelineImplCopyWithImpl<$Res>
    extends _$TimelineCopyWithImpl<$Res, _$TimelineImpl>
    implements _$$TimelineImplCopyWith<$Res> {
  __$$TimelineImplCopyWithImpl(
      _$TimelineImpl _value, $Res Function(_$TimelineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? isRead = null,
    Object? postCreatorUid = null,
    Object? postId = null,
  }) {
    return _then(_$TimelineImpl(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimelineImpl implements _Timeline {
  const _$TimelineImpl(
      {required this.createdAt,
      required this.isRead,
      required this.postCreatorUid,
      required this.postId});

  factory _$TimelineImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimelineImplFromJson(json);

  @override
  final dynamic createdAt;
//フォロワーが投稿を読み込んだかどうか
  @override
  final bool isRead;
  @override
  final String postCreatorUid;
  @override
  final String postId;

  @override
  String toString() {
    return 'Timeline(createdAt: $createdAt, isRead: $isRead, postCreatorUid: $postCreatorUid, postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimelineImpl &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.postCreatorUid, postCreatorUid) ||
                other.postCreatorUid == postCreatorUid) &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      isRead,
      postCreatorUid,
      postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimelineImplCopyWith<_$TimelineImpl> get copyWith =>
      __$$TimelineImplCopyWithImpl<_$TimelineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimelineImplToJson(
      this,
    );
  }
}

abstract class _Timeline implements Timeline {
  const factory _Timeline(
      {required final dynamic createdAt,
      required final bool isRead,
      required final String postCreatorUid,
      required final String postId}) = _$TimelineImpl;

  factory _Timeline.fromJson(Map<String, dynamic> json) =
      _$TimelineImpl.fromJson;

  @override
  dynamic get createdAt;
  @override //フォロワーが投稿を読み込んだかどうか
  bool get isRead;
  @override
  String get postCreatorUid;
  @override
  String get postId;
  @override
  @JsonKey(ignore: true)
  _$$TimelineImplCopyWith<_$TimelineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
