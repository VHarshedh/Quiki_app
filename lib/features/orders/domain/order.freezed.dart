// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppOrder {

 String get id; String get userId; List<CartItem> get items; double get totalAmount; OrderStatus get status; DateTime get createdAt; String get addressId; String get paymentMethod; String get cancelNote;
/// Create a copy of AppOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppOrderCopyWith<AppOrder> get copyWith => _$AppOrderCopyWithImpl<AppOrder>(this as AppOrder, _$identity);

  /// Serializes this AppOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cancelNote, cancelNote) || other.cancelNote == cancelNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(items),totalAmount,status,createdAt,addressId,paymentMethod,cancelNote);

@override
String toString() {
  return 'AppOrder(id: $id, userId: $userId, items: $items, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, addressId: $addressId, paymentMethod: $paymentMethod, cancelNote: $cancelNote)';
}


}

/// @nodoc
abstract mixin class $AppOrderCopyWith<$Res>  {
  factory $AppOrderCopyWith(AppOrder value, $Res Function(AppOrder) _then) = _$AppOrderCopyWithImpl;
@useResult
$Res call({
 String id, String userId, List<CartItem> items, double totalAmount, OrderStatus status, DateTime createdAt, String addressId, String paymentMethod, String cancelNote
});




}
/// @nodoc
class _$AppOrderCopyWithImpl<$Res>
    implements $AppOrderCopyWith<$Res> {
  _$AppOrderCopyWithImpl(this._self, this._then);

  final AppOrder _self;
  final $Res Function(AppOrder) _then;

/// Create a copy of AppOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? items = null,Object? totalAmount = null,Object? status = null,Object? createdAt = null,Object? addressId = null,Object? paymentMethod = null,Object? cancelNote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,addressId: null == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,cancelNote: null == cancelNote ? _self.cancelNote : cancelNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppOrder].
extension AppOrderPatterns on AppOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppOrder value)  $default,){
final _that = this;
switch (_that) {
case _AppOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppOrder value)?  $default,){
final _that = this;
switch (_that) {
case _AppOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  List<CartItem> items,  double totalAmount,  OrderStatus status,  DateTime createdAt,  String addressId,  String paymentMethod,  String cancelNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppOrder() when $default != null:
return $default(_that.id,_that.userId,_that.items,_that.totalAmount,_that.status,_that.createdAt,_that.addressId,_that.paymentMethod,_that.cancelNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  List<CartItem> items,  double totalAmount,  OrderStatus status,  DateTime createdAt,  String addressId,  String paymentMethod,  String cancelNote)  $default,) {final _that = this;
switch (_that) {
case _AppOrder():
return $default(_that.id,_that.userId,_that.items,_that.totalAmount,_that.status,_that.createdAt,_that.addressId,_that.paymentMethod,_that.cancelNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  List<CartItem> items,  double totalAmount,  OrderStatus status,  DateTime createdAt,  String addressId,  String paymentMethod,  String cancelNote)?  $default,) {final _that = this;
switch (_that) {
case _AppOrder() when $default != null:
return $default(_that.id,_that.userId,_that.items,_that.totalAmount,_that.status,_that.createdAt,_that.addressId,_that.paymentMethod,_that.cancelNote);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppOrder extends AppOrder {
  const _AppOrder({required this.id, required this.userId, required final  List<CartItem> items, required this.totalAmount, required this.status, required this.createdAt, this.addressId = '', this.paymentMethod = '', this.cancelNote = ''}): _items = items,super._();
  factory _AppOrder.fromJson(Map<String, dynamic> json) => _$AppOrderFromJson(json);

@override final  String id;
@override final  String userId;
 final  List<CartItem> _items;
@override List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double totalAmount;
@override final  OrderStatus status;
@override final  DateTime createdAt;
@override@JsonKey() final  String addressId;
@override@JsonKey() final  String paymentMethod;
@override@JsonKey() final  String cancelNote;

/// Create a copy of AppOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppOrderCopyWith<_AppOrder> get copyWith => __$AppOrderCopyWithImpl<_AppOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalAmount, totalAmount) || other.totalAmount == totalAmount)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.addressId, addressId) || other.addressId == addressId)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.cancelNote, cancelNote) || other.cancelNote == cancelNote));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,const DeepCollectionEquality().hash(_items),totalAmount,status,createdAt,addressId,paymentMethod,cancelNote);

@override
String toString() {
  return 'AppOrder(id: $id, userId: $userId, items: $items, totalAmount: $totalAmount, status: $status, createdAt: $createdAt, addressId: $addressId, paymentMethod: $paymentMethod, cancelNote: $cancelNote)';
}


}

/// @nodoc
abstract mixin class _$AppOrderCopyWith<$Res> implements $AppOrderCopyWith<$Res> {
  factory _$AppOrderCopyWith(_AppOrder value, $Res Function(_AppOrder) _then) = __$AppOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, List<CartItem> items, double totalAmount, OrderStatus status, DateTime createdAt, String addressId, String paymentMethod, String cancelNote
});




}
/// @nodoc
class __$AppOrderCopyWithImpl<$Res>
    implements _$AppOrderCopyWith<$Res> {
  __$AppOrderCopyWithImpl(this._self, this._then);

  final _AppOrder _self;
  final $Res Function(_AppOrder) _then;

/// Create a copy of AppOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? items = null,Object? totalAmount = null,Object? status = null,Object? createdAt = null,Object? addressId = null,Object? paymentMethod = null,Object? cancelNote = null,}) {
  return _then(_AppOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,totalAmount: null == totalAmount ? _self.totalAmount : totalAmount // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,addressId: null == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String,cancelNote: null == cancelNote ? _self.cancelNote : cancelNote // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
