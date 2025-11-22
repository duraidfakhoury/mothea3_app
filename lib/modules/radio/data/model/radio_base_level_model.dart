import 'package:mothea3_app/modules/radio/domian/entity/radio_base_level.dart';

class RadioBaseLevelModel extends RadioBaseLevel {
  const RadioBaseLevelModel({required super.title, required super.id , required super.locked}); 
  factory RadioBaseLevelModel.fromJson (Map<String,dynamic> json) {
    return RadioBaseLevelModel(
      title: json["title"], 
      id:json["id"],
      locked: json["locked"]
       );
  }
}