// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardModel _$DashboardModelFromJson(Map<String, dynamic> json) {
  return DashboardModel(
    totalProduct: json['totalProduct'] as int,
    totalCategory: json['totalCategory'] as int,
    totalUser: json['totalUser'] as int,
  );
}

Map<String, dynamic> _$DashboardModelToJson(DashboardModel instance) =>
    <String, dynamic>{
      'totalProduct': instance.totalProduct,
      'totalCategory': instance.totalCategory,
      'totalUser': instance.totalUser,
    };
