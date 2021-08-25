import 'package:json_annotation/json_annotation.dart';

part 'dashboardg.dart';

@JsonSerializable()
class DashboardModel {
  int totalProduct;
  int totalCategory;
  int totalUser;
  DashboardModel(
      {this.totalProduct,
        this.totalCategory,
        this.totalUser
        });

  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardModelToJson(this);
}
