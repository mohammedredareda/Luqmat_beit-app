// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState()';
}


}

/// @nodoc
class $NotificationsStateCopyWith<$Res>  {
$NotificationsStateCopyWith(NotificationsState _, $Res Function(NotificationsState) __);
}


/// Adds pattern-matching-related methods to [NotificationsState].
extension NotificationsStatePatterns on NotificationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationsInitial value)?  initial,TResult Function( NotificationsLoading value)?  loading,TResult Function( NotificationsLoaded value)?  loaded,TResult Function( NotificationsFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationsInitial() when initial != null:
return initial(_that);case NotificationsLoading() when loading != null:
return loading(_that);case NotificationsLoaded() when loaded != null:
return loaded(_that);case NotificationsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationsInitial value)  initial,required TResult Function( NotificationsLoading value)  loading,required TResult Function( NotificationsLoaded value)  loaded,required TResult Function( NotificationsFailure value)  failure,}){
final _that = this;
switch (_that) {
case NotificationsInitial():
return initial(_that);case NotificationsLoading():
return loading(_that);case NotificationsLoaded():
return loaded(_that);case NotificationsFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationsInitial value)?  initial,TResult? Function( NotificationsLoading value)?  loading,TResult? Function( NotificationsLoaded value)?  loaded,TResult? Function( NotificationsFailure value)?  failure,}){
final _that = this;
switch (_that) {
case NotificationsInitial() when initial != null:
return initial(_that);case NotificationsLoading() when loading != null:
return loading(_that);case NotificationsLoaded() when loaded != null:
return loaded(_that);case NotificationsFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<NotificationEntity> notifications,  NotificationsTab selectedTab)?  loaded,TResult Function( AppException exception)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationsInitial() when initial != null:
return initial();case NotificationsLoading() when loading != null:
return loading();case NotificationsLoaded() when loaded != null:
return loaded(_that.notifications,_that.selectedTab);case NotificationsFailure() when failure != null:
return failure(_that.exception);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<NotificationEntity> notifications,  NotificationsTab selectedTab)  loaded,required TResult Function( AppException exception)  failure,}) {final _that = this;
switch (_that) {
case NotificationsInitial():
return initial();case NotificationsLoading():
return loading();case NotificationsLoaded():
return loaded(_that.notifications,_that.selectedTab);case NotificationsFailure():
return failure(_that.exception);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<NotificationEntity> notifications,  NotificationsTab selectedTab)?  loaded,TResult? Function( AppException exception)?  failure,}) {final _that = this;
switch (_that) {
case NotificationsInitial() when initial != null:
return initial();case NotificationsLoading() when loading != null:
return loading();case NotificationsLoaded() when loaded != null:
return loaded(_that.notifications,_that.selectedTab);case NotificationsFailure() when failure != null:
return failure(_that.exception);case _:
  return null;

}
}

}

/// @nodoc


class NotificationsInitial implements NotificationsState {
  const NotificationsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState.initial()';
}


}




/// @nodoc


class NotificationsLoading implements NotificationsState {
  const NotificationsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsState.loading()';
}


}




/// @nodoc


class NotificationsLoaded implements NotificationsState {
  const NotificationsLoaded(final  List<NotificationEntity> notifications, {this.selectedTab = NotificationsTab.personal}): _notifications = notifications;
  

 final  List<NotificationEntity> _notifications;
 List<NotificationEntity> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

@JsonKey() final  NotificationsTab selectedTab;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsLoadedCopyWith<NotificationsLoaded> get copyWith => _$NotificationsLoadedCopyWithImpl<NotificationsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsLoaded&&const DeepCollectionEquality().equals(other._notifications, _notifications)&&(identical(other.selectedTab, selectedTab) || other.selectedTab == selectedTab));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications),selectedTab);

@override
String toString() {
  return 'NotificationsState.loaded(notifications: $notifications, selectedTab: $selectedTab)';
}


}

/// @nodoc
abstract mixin class $NotificationsLoadedCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory $NotificationsLoadedCopyWith(NotificationsLoaded value, $Res Function(NotificationsLoaded) _then) = _$NotificationsLoadedCopyWithImpl;
@useResult
$Res call({
 List<NotificationEntity> notifications, NotificationsTab selectedTab
});




}
/// @nodoc
class _$NotificationsLoadedCopyWithImpl<$Res>
    implements $NotificationsLoadedCopyWith<$Res> {
  _$NotificationsLoadedCopyWithImpl(this._self, this._then);

  final NotificationsLoaded _self;
  final $Res Function(NotificationsLoaded) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notifications = null,Object? selectedTab = null,}) {
  return _then(NotificationsLoaded(
null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationEntity>,selectedTab: null == selectedTab ? _self.selectedTab : selectedTab // ignore: cast_nullable_to_non_nullable
as NotificationsTab,
  ));
}


}

/// @nodoc


class NotificationsFailure implements NotificationsState {
  const NotificationsFailure(this.exception);
  

 final  AppException exception;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsFailureCopyWith<NotificationsFailure> get copyWith => _$NotificationsFailureCopyWithImpl<NotificationsFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsFailure&&(identical(other.exception, exception) || other.exception == exception));
}


@override
int get hashCode => Object.hash(runtimeType,exception);

@override
String toString() {
  return 'NotificationsState.failure(exception: $exception)';
}


}

/// @nodoc
abstract mixin class $NotificationsFailureCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory $NotificationsFailureCopyWith(NotificationsFailure value, $Res Function(NotificationsFailure) _then) = _$NotificationsFailureCopyWithImpl;
@useResult
$Res call({
 AppException exception
});




}
/// @nodoc
class _$NotificationsFailureCopyWithImpl<$Res>
    implements $NotificationsFailureCopyWith<$Res> {
  _$NotificationsFailureCopyWithImpl(this._self, this._then);

  final NotificationsFailure _self;
  final $Res Function(NotificationsFailure) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exception = null,}) {
  return _then(NotificationsFailure(
null == exception ? _self.exception : exception // ignore: cast_nullable_to_non_nullable
as AppException,
  ));
}


}

// dart format on
