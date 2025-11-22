import 'package:mothea3_app/modules/television/domain/entitiy/television_base_level.dart';

class TelevisionBaseLevelModel extends TelevisionBaseLevel {
  const TelevisionBaseLevelModel({required super.title, required super.id , required super.locked}); 
  factory TelevisionBaseLevelModel.fromJson (Map<String,dynamic> json) {
    return TelevisionBaseLevelModel(
      title: json["title"], 
      id:json["id"],
      locked: json["locked"]
       );
  }
}