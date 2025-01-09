import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

part 'api_model.freezed.dart';
part 'api_model.g.dart';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

@freezed
class ApiModel with _$ApiModel {
  const factory ApiModel({
    @JsonKey(name: "success") required bool success,
    @JsonKey(name: "list") required List<ListElement> list,
    @JsonKey(name: "msg") required String msg,
  }) = _ApiModel;

  factory ApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApiModelFromJson(json);
}

@freezed
class ListElement with _$ListElement {
  const factory ListElement({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "price") required int price,
    @JsonKey(name: "image") required String image,
    @JsonKey(name: "type") required String type,
  }) = _ListElement;

  factory ListElement.fromJson(Map<String, dynamic> json) =>
      _$ListElementFromJson(json);

  static Future<List<ListElement>> fetchProducts() async {
    const String url = 'https://my-store.in/v2/product/api/getProductsList';
    final response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['list'] as List)
          .map((json) => ListElement.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
