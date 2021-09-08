// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Plan _$_$_PlanFromJson(Map<String, dynamic> json) {
  return _$_Plan(
    name: json['name'] as String? ?? '',
    tasks: (json['tasks'] as List<dynamic>?)
            ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$_$_PlanToJson(_$_Plan instance) => <String, dynamic>{
      'name': instance.name,
      'tasks': instance.tasks,
    };
