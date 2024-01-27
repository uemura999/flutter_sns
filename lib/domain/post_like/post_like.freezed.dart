// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostLike _$PostLikeFromJson(Map<String, dynamic> json) {
  return _PostLike.fromJson(json);
}

/// @nodoc
mixin _$PostLike {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get passiveUid => throw _privateConstructorUsedError;
  dynamic get postRef => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostLikeCopyWith<PostLike> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostLikeCopyWith<$Res> {
  factory $PostLikeCopyWith(PostLike value, $Res Function(PostLike) then) =
      _$PostLikeCopyWithImpl<$Res, PostLike>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String passiveUid,
      dynamic postRef,
      String postId});
}

/// @nodoc
class _$PostLikeCopyWithImpl<$Res, $Val extends PostLike>
    implements $PostLikeCopyWith<$Res> {
  _$PostLikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? passiveUid = null,
    Object? postRef = freezed,
    Object? postId = null,
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
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostLikeImplCopyWith<$Res>
    implements $PostLikeCopyWith<$Res> {
  factory _$$PostLikeImplCopyWith(
          _$PostLikeImpl value, $Res Function(_$PostLikeImpl) then) =
      __$$PostLikeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String passiveUid,
      dynamic postRef,
      String postId});
}

/// @nodoc
class __$$PostLikeImplCopyWithImpl<$Res>
    extends _$PostLikeCopyWithImpl<$Res, _$PostLikeImpl>
    implements _$$PostLikeImplCopyWith<$Res> {
  __$$PostLikeImplCopyWithImpl(
      _$PostLikeImpl _value, $Res Function(_$PostLikeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? passiveUid = null,
    Object? postRef = freezed,
    Object? postId = null,
  }) {
    return _then(_$PostLikeImpl(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostLikeImpl implements _PostLike {
  const _$PostLikeImpl(
      {required this.activeUid,
      required this.createdAt,
      required this.passiveUid,
      required this.postRef,
      required this.postId});

  factory _$PostLikeImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostLikeImplFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String passiveUid;
  @override
  final dynamic postRef;
  @override
  final String postId;

  @override
  String toString() {
    return 'PostLike(activeUid: $activeUid, createdAt: $createdAt, passiveUid: $passiveUid, postRef: $postRef, postId: $postId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostLikeImpl &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.passiveUid, passiveUid) ||
                other.passiveUid == passiveUid) &&
            const DeepCollectionEquality().equals(other.postRef, postRef) &&
            (identical(other.postId, postId) || other.postId == postId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeUid,
      const DeepCollectionEquality().hash(createdAt),
      passiveUid,
      const DeepCollectionEquality().hash(postRef),
      postId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostLikeImplCopyWith<_$PostLikeImpl> get copyWith =>
      __$$PostLikeImplCopyWithImpl<_$PostLikeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostLikeImplToJson(
      this,
    );
  }
}

abstract class _PostLike implements PostLike {
  const factory _PostLike(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String passiveUid,
      required final dynamic postRef,
      required final String postId}) = _$PostLikeImpl;

  factory _PostLike.fromJson(Map<String, dynamic> json) =
      _$PostLikeImpl.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get passiveUid;
  @override
  dynamic get postRef;
  @override
  String get postId;
  @override
  @JsonKey(ignore: true)
  _$$PostLikeImplCopyWith<_$PostLikeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
