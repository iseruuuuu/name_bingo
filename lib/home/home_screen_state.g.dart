// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeScreenStateImpl _$$HomeScreenStateImplFromJson(
        Map<String, dynamic> json) =>
    _$HomeScreenStateImpl(
      selectedItem: json['selectedItem'] as String,
      select: json['select'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$HomeScreenStateImplToJson(
        _$HomeScreenStateImpl instance) =>
    <String, dynamic>{
      'selectedItem': instance.selectedItem,
      'select': instance.select,
      'isActive': instance.isActive,
    };
