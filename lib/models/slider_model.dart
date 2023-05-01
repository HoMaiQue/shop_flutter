import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SliderModel {
  int id;
  String name;
  String image;
  SliderModel({
    required this.id,
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory SliderModel.fromMap(Map<String, dynamic> map) {
    return SliderModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SliderModel.fromJson(String source) =>
      SliderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
