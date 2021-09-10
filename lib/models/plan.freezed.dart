// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Plan _$PlanFromJson(Map<String, dynamic> json) {
  return _Plan.fromJson(json);
}

/// @nodoc
class _$PlanTearOff {
  const _$PlanTearOff();

  _Plan call({String? name = '', List<Task>? tasks = const []}) {
    return _Plan(
      name: name,
      tasks: tasks,
    );
  }

  Plan fromJson(Map<String, Object> json) {
    return Plan.fromJson(json);
  }
}

/// @nodoc
const $Plan = _$PlanTearOff();

/// @nodoc
mixin _$Plan {
  String? get name => throw _privateConstructorUsedError;
  List<Task>? get tasks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlanCopyWith<Plan> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanCopyWith<$Res> {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) then) =
      _$PlanCopyWithImpl<$Res>;
  $Res call({String? name, List<Task>? tasks});
}

/// @nodoc
class _$PlanCopyWithImpl<$Res> implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._value, this._then);

  final Plan _value;
  // ignore: unused_field
  final $Res Function(Plan) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? tasks = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      tasks: tasks == freezed
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>?,
    ));
  }
}

/// @nodoc
abstract class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) then) =
      __$PlanCopyWithImpl<$Res>;
  @override
  $Res call({String? name, List<Task>? tasks});
}

/// @nodoc
class __$PlanCopyWithImpl<$Res> extends _$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(_Plan _value, $Res Function(_Plan) _then)
      : super(_value, (v) => _then(v as _Plan));

  @override
  _Plan get _value => super._value as _Plan;

  @override
  $Res call({
    Object? name = freezed,
    Object? tasks = freezed,
  }) {
    return _then(_Plan(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      tasks: tasks == freezed
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<Task>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Plan extends _Plan with DiagnosticableTreeMixin {
  _$_Plan({this.name = '', this.tasks = const []}) : super._();

  factory _$_Plan.fromJson(Map<String, dynamic> json) => _$$_PlanFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String? name;
  @JsonKey(defaultValue: const [])
  @override
  final List<Task>? tasks;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Plan(name: $name, tasks: $tasks)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Plan'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('tasks', tasks));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Plan &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.tasks, tasks) ||
                const DeepCollectionEquality().equals(other.tasks, tasks)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(tasks);

  @JsonKey(ignore: true)
  @override
  _$PlanCopyWith<_Plan> get copyWith =>
      __$PlanCopyWithImpl<_Plan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlanToJson(this);
  }
}

abstract class _Plan extends Plan {
  factory _Plan({String? name, List<Task>? tasks}) = _$_Plan;
  _Plan._() : super._();

  factory _Plan.fromJson(Map<String, dynamic> json) = _$_Plan.fromJson;

  @override
  String? get name => throw _privateConstructorUsedError;
  @override
  List<Task>? get tasks => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PlanCopyWith<_Plan> get copyWith => throw _privateConstructorUsedError;
}
