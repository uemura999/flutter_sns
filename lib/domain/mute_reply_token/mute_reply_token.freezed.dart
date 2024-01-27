// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mute_reply_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MuteReplyToken _$MuteReplyTokenFromJson(Map<String, dynamic> json) {
  return _MuteReplyToken.fromJson(json);
}

/// @nodoc
mixin _$MuteReplyToken {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get postCommentReplyId => throw _privateConstructorUsedError;
  dynamic get postCommentReplyRef => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MuteReplyTokenCopyWith<MuteReplyToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MuteReplyTokenCopyWith<$Res> {
  factory $MuteReplyTokenCopyWith(
          MuteReplyToken value, $Res Function(MuteReplyToken) then) =
      _$MuteReplyTokenCopyWithImpl<$Res, MuteReplyToken>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCommentReplyId,
      dynamic postCommentReplyRef,
      String tokenId,
      String tokenType});
}

/// @nodoc
class _$MuteReplyTokenCopyWithImpl<$Res, $Val extends MuteReplyToken>
    implements $MuteReplyTokenCopyWith<$Res> {
  _$MuteReplyTokenCopyWithImpl(this._value, this._then);

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
    Object? tokenId = null,
    Object? tokenType = null,
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
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MuteReplyTokenImplCopyWith<$Res>
    implements $MuteReplyTokenCopyWith<$Res> {
  factory _$$MuteReplyTokenImplCopyWith(_$MuteReplyTokenImpl value,
          $Res Function(_$MuteReplyTokenImpl) then) =
      __$$MuteReplyTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCommentReplyId,
      dynamic postCommentReplyRef,
      String tokenId,
      String tokenType});
}

/// @nodoc
class __$$MuteReplyTokenImplCopyWithImpl<$Res>
    extends _$MuteReplyTokenCopyWithImpl<$Res, _$MuteReplyTokenImpl>
    implements _$$MuteReplyTokenImplCopyWith<$Res> {
  __$$MuteReplyTokenImplCopyWithImpl(
      _$MuteReplyTokenImpl _value, $Res Function(_$MuteReplyTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postCommentReplyId = null,
    Object? postCommentReplyRef = freezed,
    Object? tokenId = null,
    Object? tokenType = null,
  }) {
    return _then(_$MuteReplyTokenImpl(
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
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MuteReplyTokenImpl implements _MuteReplyToken {
  const _$MuteReplyTokenImpl(
      {required this.activeUid,
      required this.createdAt,
      required this.postCommentReplyId,
      required this.postCommentReplyRef,
      required this.tokenId,
      required this.tokenType});

  factory _$MuteReplyTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$MuteReplyTokenImplFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String postCommentReplyId;
  @override
  final dynamic postCommentReplyRef;
  @override
  final String tokenId;
  @override
  final String tokenType;

  @override
  String toString() {
    return 'MuteReplyToken(activeUid: $activeUid, createdAt: $createdAt, postCommentReplyId: $postCommentReplyId, postCommentReplyRef: $postCommentReplyRef, tokenId: $tokenId, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MuteReplyTokenImpl &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.postCommentReplyId, postCommentReplyId) ||
                other.postCommentReplyId == postCommentReplyId) &&
            const DeepCollectionEquality()
                .equals(other.postCommentReplyRef, postCommentReplyRef) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeUid,
      const DeepCollectionEquality().hash(createdAt),
      postCommentReplyId,
      const DeepCollectionEquality().hash(postCommentReplyRef),
      tokenId,
      tokenType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MuteReplyTokenImplCopyWith<_$MuteReplyTokenImpl> get copyWith =>
      __$$MuteReplyTokenImplCopyWithImpl<_$MuteReplyTokenImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MuteReplyTokenImplToJson(
      this,
    );
  }
}

abstract class _MuteReplyToken implements MuteReplyToken {
  const factory _MuteReplyToken(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String postCommentReplyId,
      required final dynamic postCommentReplyRef,
      required final String tokenId,
      required final String tokenType}) = _$MuteReplyTokenImpl;

  factory _MuteReplyToken.fromJson(Map<String, dynamic> json) =
      _$MuteReplyTokenImpl.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get postCommentReplyId;
  @override
  dynamic get postCommentReplyRef;
  @override
  String get tokenId;
  @override
  String get tokenType;
  @override
  @JsonKey(ignore: true)
  _$$MuteReplyTokenImplCopyWith<_$MuteReplyTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
