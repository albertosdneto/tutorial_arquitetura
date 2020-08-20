import 'dart:convert';
import 'package:tutorial_arquitetura/modules/search/domain/entities/result_search.dart';


class ResultSearchModel extends ResultSearch {
  final String name;
  final String image;
  final String url;

  ResultSearchModel({this.name, this.image, this.url});

  Map<String, dynamic> toMap() {
    return {
      "login": name,
      "img": image,
      "html_url": url,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ResultSearchModel(
      name: map["login"],
      image: map["avatar_url"],
      url: map["html_url"],
    );
  }

  String toJson() => json.encode(toMap());

  static ResultSearchModel formJson(String source) =>
      fromMap(json.decode(source));


}
