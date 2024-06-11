import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan {
  String id;
  String title;
  String reja;
  String sana;
  bool isDone;
  Plan({
    required this.id,
    required this.title,
    required this.reja,
    required this.sana,
    
    this.isDone = false,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    return _$PlanFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PlanToJson(this);
  }
}
