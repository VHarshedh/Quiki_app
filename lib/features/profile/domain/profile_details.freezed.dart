// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileDetails {

 String get name; String get phone; String get image;
/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDetailsCopyWith<ProfileDetails> get copyWith => _$ProfileDetailsCopyWithImpl<ProfileDetails>(this as ProfileDetails, _$identity);

  /// Serializes this ProfileDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,image);

@override
String toString() {
  return 'ProfileDetails(name: $name, phone: $phone, image: $image)';
}


}

/// @nodoc
abstract mixin class $ProfileDetailsCopyWith<$Res>  {
  factory $ProfileDetailsCopyWith(ProfileDetails value, $Res Function(ProfileDetails) _then) = _$ProfileDetailsCopyWithImpl;
@useResult
$Res call({
 String name, String phone, String image
});




}
/// @nodoc
class _$ProfileDetailsCopyWithImpl<$Res>
    implements $ProfileDetailsCopyWith<$Res> {
  _$ProfileDetailsCopyWithImpl(this._self, this._then);

  final ProfileDetails _self;
  final $Res Function(ProfileDetails) _then;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? phone = null,Object? image = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileDetails].
extension ProfileDetailsPatterns on ProfileDetails {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileDetails value)  $default,){
final _that = this;
switch (_that) {
case _ProfileDetails():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileDetails value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String phone,  String image)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that.name,_that.phone,_that.image);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String phone,  String image)  $default,) {final _that = this;
switch (_that) {
case _ProfileDetails():
return $default(_that.name,_that.phone,_that.image);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String phone,  String image)?  $default,) {final _that = this;
switch (_that) {
case _ProfileDetails() when $default != null:
return $default(_that.name,_that.phone,_that.image);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileDetails extends ProfileDetails {
  const _ProfileDetails({this.name = '', this.phone = '', this.image = ''}): super._();
  factory _ProfileDetails.fromJson(Map<String, dynamic> json) => _$ProfileDetailsFromJson(json);

@override@JsonKey() final  String name;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String image;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDetailsCopyWith<_ProfileDetails> get copyWith => __$ProfileDetailsCopyWithImpl<_ProfileDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDetails&&(identical(other.name, name) || other.name == name)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,phone,image);

@override
String toString() {
  return 'ProfileDetails(name: $name, phone: $phone, image: $image)';
}


}

/// @nodoc
abstract mixin class _$ProfileDetailsCopyWith<$Res> implements $ProfileDetailsCopyWith<$Res> {
  factory _$ProfileDetailsCopyWith(_ProfileDetails value, $Res Function(_ProfileDetails) _then) = __$ProfileDetailsCopyWithImpl;
@override @useResult
$Res call({
 String name, String phone, String image
});




}
/// @nodoc
class __$ProfileDetailsCopyWithImpl<$Res>
    implements _$ProfileDetailsCopyWith<$Res> {
  __$ProfileDetailsCopyWithImpl(this._self, this._then);

  final _ProfileDetails _self;
  final $Res Function(_ProfileDetails) _then;

/// Create a copy of ProfileDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? phone = null,Object? image = null,}) {
  return _then(_ProfileDetails(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
