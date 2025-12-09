import 'package:mothea3_app/modules/cultural/domain/entity/cultural_base_level.dart';

class CulturalBaseLevelModel extends CulturalBaseLevel {
  const CulturalBaseLevelModel({
    required super.title,
    required super.id,
    required super.status,
  });
  factory CulturalBaseLevelModel.fromJson(Map<String, dynamic> json) {
    return CulturalBaseLevelModel(
      title: json["title"],
      id: json["id"],
      status: json["status"],
    );
  }
}
