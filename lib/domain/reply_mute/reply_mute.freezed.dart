// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_mute.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReplyMute _$ReplyMuteFromJson(Map<String, dynamic> json) {
  return _ReplyMute.fromJson(json);
}

/// @nodoc
mixin _$ReplyMute {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get postCommentReplyId => throw _privateConstructorUsedError;
  dynamic get postCommentReplyRef => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyMuteCopyWith<ReplyMute> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyMuteCopyWith<$Res> {
  factory $ReplyMuteCopyWith(ReplyMute value, $Res Function(ReplyMute) then) =
      _$ReplyMuteCopyWithImpl<$Res, ReplyMute>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCommentReplyId,
      dynamic postCommentReplyRef});
}

/// @nodoc
class _$ReplyMuteCopyWithImpl<$Res, $Val extends ReplyMute>
    implements $ReplyMuteCopyWith<$Res> {
  _$ReplyMuteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postCommentReplyId = null,
    Object? postCommentReplyRef = freezed,
  }) {
    return _then(_value.copyWith(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentReplyId: null == postCommentReplyId
          ? _value.postCommentReplyId
          : postCommentReplyId // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentReplyRef: freezed == postCommentReplyRef
          ? _value.postCommentReplyRef
          : postCommentReplyRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReplyMuteImplCopyWith<$Res>
    implements $ReplyMuteCopyWith<$Res> {
  factory _$$ReplyMuteImplCopyWith(
          _$ReplyMuteImpl value, $Res Function(_$ReplyMuteImpl) then) =
      __$$ReplyMuteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCommentReplyId,
      dynamic postCommentReplyRef});
}

/// @nodoc
class __$$ReplyMuteImplCopyWithImpl<$Res>
    extends _$ReplyMuteCopyWithImpl<$Res, _$ReplyMuteImpl>
    implements _$$ReplyMuteImplCopyWith<$Res> {
  __$$ReplyMuteImplCopyWithImpl(
      _$ReplyMuteImpl _value, $Res Function(_$ReplyMuteImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postCommentReplyId = null,
    Object? postCommentReplyRef = freezed,
  }) {
    return _then(_$ReplyMuteImpl(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentReplyId: null == postCommentReplyId
          ? _value.postCommentReplyId
          : postCommentReplyId // ignore: cast_nullable_to_non_nullable
              as String,
      postCommentReplyRef: freezed == postCommentReplyRef
          ? _value.postCommentReplyRef
          : postCommentReplyRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyMuteImpl implements _ReplyMute {
  const _$ReplyMuteImpl(
      {required this.activeUid,
      required this.createdAt,
      required this.postCommentReplyId,
      required this.postCommentReplyRef});

  factory _$ReplyMuteImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyMuteImplFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String postCommentReplyId;
  @override
  final dynamic postCommentReplyRef;

  @override
  String toString() {
    return 'ReplyMute(activeUid: $activeUid, createdAt: $createdAt, postCommentReplyId: $postCommentReplyId, postCommentReplyRef: $postCommentReplyRef)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyMuteImpl &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.postCommentReplyId, postCommentReplyId) ||
                other.postCommentReplyId == postCommentReplyId) &&
            const DeepCollectionEquality()
                .equals(other.postCommentReplyRef, postCommentReplyRef));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeUid,
      const DeepCollectionEquality().hash(createdAt),
      postCommentReplyId,
      const DeepCollectionEquality().hash(postCommentReplyRef));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyMuteImplCopyWith<_$ReplyMuteImpl> get copyWith =>
      __$$ReplyMuteImplCopyWithImpl<_$ReplyMuteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyMuteImplToJson(
      this,
    );
  }
}

abstract class _ReplyMute implements ReplyMute {
  const factory _ReplyMute(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String postCommentReplyId,
      required final dynamic postCommentReplyRef}) = _$ReplyMuteImpl;

  factory _ReplyMute.fromJson(Map<String, dynamic> json) =
      _$ReplyMuteImpl.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get postCommentReplyId;
  @override
  dynamic get postCommentReplyRef;
  @override
  @JsonKey(ignore: true)
  _$$ReplyMuteImplCopyWith<_$ReplyMuteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
