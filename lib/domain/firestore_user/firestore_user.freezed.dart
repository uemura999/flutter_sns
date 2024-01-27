// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firestore_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FirestoreUser _$FirestoreUserFromJson(Map<String, dynamic> json) {
  return _FirestoreUser.fromJson(json);
}

/// @nodoc
mixin _$FirestoreUser {
  dynamic get createdAt => throw _privateConstructorUsedError;
  int get followerCount => throw _privateConstructorUsedError;
  int get followingCount => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError;
  int get muteCount => throw _privateConstructorUsedError;
  dynamic get updatedAt => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FirestoreUserCopyWith<FirestoreUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FirestoreUserCopyWith<$Res> {
  factory $FirestoreUserCopyWith(
          FirestoreUser value, $Res Function(FirestoreUser) then) =
      _$FirestoreUserCopyWithImpl<$Res, FirestoreUser>;
  @useResult
  $Res call(
      {dynamic createdAt,
      int followerCount,
      int followingCount,
      bool isAdmin,
      int muteCount,
      dynamic updatedAt,
      String userName,
      String userImageURL,
      String uid});
}

/// @nodoc
class _$FirestoreUserCopyWithImpl<$Res, $Val extends FirestoreUser>
    implements $FirestoreUserCopyWith<$Res> {
  _$FirestoreUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isAdmin = null,
    Object? muteCount = null,
    Object? updatedAt = freezed,
    Object? userName = null,
    Object? userImageURL = null,
    Object? uid = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      muteCount: null == muteCount
          ? _value.muteCount
          : muteCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FirestoreUserImplCopyWith<$Res>
    implements $FirestoreUserCopyWith<$Res> {
  factory _$$FirestoreUserImplCopyWith(
          _$FirestoreUserImpl value, $Res Function(_$FirestoreUserImpl) then) =
      __$$FirestoreUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      int followerCount,
      int followingCount,
      bool isAdmin,
      int muteCount,
      dynamic updatedAt,
      String userName,
      String userImageURL,
      String uid});
}

/// @nodoc
class __$$FirestoreUserImplCopyWithImpl<$Res>
    extends _$FirestoreUserCopyWithImpl<$Res, _$FirestoreUserImpl>
    implements _$$FirestoreUserImplCopyWith<$Res> {
  __$$FirestoreUserImplCopyWithImpl(
      _$FirestoreUserImpl _value, $Res Function(_$FirestoreUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? followerCount = null,
    Object? followingCount = null,
    Object? isAdmin = null,
    Object? muteCount = null,
    Object? updatedAt = freezed,
    Object? userName = null,
    Object? userImageURL = null,
    Object? uid = null,
  }) {
    return _then(_$FirestoreUserImpl(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      muteCount: null == muteCount
          ? _value.muteCount
          : muteCount // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FirestoreUserImpl implements _FirestoreUser {
  const _$FirestoreUserImpl(
      {required this.createdAt,
      required this.followerCount,
      required this.followingCount,
      required this.isAdmin,
      required this.muteCount,
      required this.updatedAt,
      required this.userName,
      required this.userImageURL,
      required this.uid});

  factory _$FirestoreUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$FirestoreUserImplFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final int followerCount;
  @override
  final int followingCount;
  @override
  final bool isAdmin;
  @override
  final int muteCount;
  @override
  final dynamic updatedAt;
  @override
  final String userName;
  @override
  final String userImageURL;
  @override
  final String uid;

  @override
  String toString() {
    return 'FirestoreUser(createdAt: $createdAt, followerCount: $followerCount, followingCount: $followingCount, isAdmin: $isAdmin, muteCount: $muteCount, updatedAt: $updatedAt, userName: $userName, userImageURL: $userImageURL, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FirestoreUserImpl &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.muteCount, muteCount) ||
                other.muteCount == muteCount) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL) &&
            (identical(other.uid, uid) || other.uid == uid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      followerCount,
      followingCount,
      isAdmin,
      muteCount,
      const DeepCollectionEquality().hash(updatedAt),
      userName,
      userImageURL,
      uid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FirestoreUserImplCopyWith<_$FirestoreUserImpl> get copyWith =>
      __$$FirestoreUserImplCopyWithImpl<_$FirestoreUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FirestoreUserImplToJson(
      this,
    );
  }
}

abstract class _FirestoreUser implements FirestoreUser {
  const factory _FirestoreUser(
      {required final dynamic createdAt,
      required final int followerCount,
      required final int followingCount,
      required final bool isAdmin,
      required final int muteCount,
      required final dynamic updatedAt,
      required final String userName,
      required final String userImageURL,
      required final String uid}) = _$FirestoreUserImpl;

  factory _FirestoreUser.fromJson(Map<String, dynamic> json) =
      _$FirestoreUserImpl.fromJson;

  @override
  dynamic get createdAt;
  @override
  int get followerCount;
  @override
  int get followingCount;
  @override
  bool get isAdmin;
  @override
  int get muteCount;
  @override
  dynamic get updatedAt;
  @override
  String get userName;
  @override
  String get userImageURL;
  @override
  String get uid;
  @override
  @JsonKey(ignore: true)
  _$$FirestoreUserImplCopyWith<_$FirestoreUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
