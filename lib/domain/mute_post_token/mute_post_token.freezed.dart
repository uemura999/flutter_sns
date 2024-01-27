// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mute_post_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MutePostToken _$MutePostTokenFromJson(Map<String, dynamic> json) {
  return _MutePostToken.fromJson(json);
}

/// @nodoc
mixin _$MutePostToken {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  dynamic get postRef => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MutePostTokenCopyWith<MutePostToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MutePostTokenCopyWith<$Res> {
  factory $MutePostTokenCopyWith(
          MutePostToken value, $Res Function(MutePostToken) then) =
      _$MutePostTokenCopyWithImpl<$Res, MutePostToken>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postId,
      dynamic postRef,
      String tokenId,
      String tokenType});
}

/// @nodoc
class _$MutePostTokenCopyWithImpl<$Res, $Val extends MutePostToken>
    implements $MutePostTokenCopyWith<$Res> {
  _$MutePostTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postId = null,
    Object? postRef = freezed,
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
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MutePostTokenImplCopyWith<$Res>
    implements $MutePostTokenCopyWith<$Res> {
  factory _$$MutePostTokenImplCopyWith(
          _$MutePostTokenImpl value, $Res Function(_$MutePostTokenImpl) then) =
      __$$MutePostTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postId,
      dynamic postRef,
      String tokenId,
      String tokenType});
}

/// @nodoc
class __$$MutePostTokenImplCopyWithImpl<$Res>
    extends _$MutePostTokenCopyWithImpl<$Res, _$MutePostTokenImpl>
    implements _$$MutePostTokenImplCopyWith<$Res> {
  __$$MutePostTokenImplCopyWithImpl(
      _$MutePostTokenImpl _value, $Res Function(_$MutePostTokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postId = null,
    Object? postRef = freezed,
    Object? tokenId = null,
    Object? tokenType = null,
  }) {
    return _then(_$MutePostTokenImpl(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
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
class _$MutePostTokenImpl implements _MutePostToken {
  const _$MutePostTokenImpl(
      {required this.activeUid,
      required this.createdAt,
      required this.postId,
      required this.postRef,
      required this.tokenId,
      required this.tokenType});

  factory _$MutePostTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$MutePostTokenImplFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String postId;
  @override
  final dynamic postRef;
  @override
  final String tokenId;
  @override
  final String tokenType;

  @override
  String toString() {
    return 'MutePostToken(activeUid: $activeUid, createdAt: $createdAt, postId: $postId, postRef: $postRef, tokenId: $tokenId, tokenType: $tokenType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MutePostTokenImpl &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            const DeepCollectionEquality().equals(other.postRef, postRef) &&
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
      postId,
      const DeepCollectionEquality().hash(postRef),
      tokenId,
      tokenType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MutePostTokenImplCopyWith<_$MutePostTokenImpl> get copyWith =>
      __$$MutePostTokenImplCopyWithImpl<_$MutePostTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MutePostTokenImplToJson(
      this,
    );
  }
}

abstract class _MutePostToken implements MutePostToken {
  const factory _MutePostToken(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String postId,
      required final dynamic postRef,
      required final String tokenId,
      required final String tokenType}) = _$MutePostTokenImpl;

  factory _MutePostToken.fromJson(Map<String, dynamic> json) =
      _$MutePostTokenImpl.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get postId;
  @override
  dynamic get postRef;
  @override
  String get tokenId;
  @override
  String get tokenType;
  @override
  @JsonKey(ignore: true)
  _$$MutePostTokenImplCopyWith<_$MutePostTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
