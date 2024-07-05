import 'dart:convert';

import 'package:shared/domain/entities/entities.dart';

class ResultModel implements ResultEntity {
  @override
  final String image;
  @override
  final String name;
  @override
  final String nickname;
  @override
  final String url;

  const ResultModel(
      {required this.image,
      required this.name,
      required this.nickname,
      required this.url});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'nickname': nickname,
      'url': url,
    };
  }

  static ResultModel fromMap(Map<String, dynamic> map) {
    return ResultModel(
      image: map['image'],
      name: map['name'],
      nickname: map['nickname'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  static ResultModel fromJson(String source) => fromMap(json.decode(source));
}
