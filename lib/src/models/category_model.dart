import 'package:json_annotation/json_annotation.dart';

import 'package:greengrocer/src/models/item_model.dart';

// Arquivo que será auto-gerado
part 'category_model.g.dart';

// Sobre a questão json X classe
// Esta classe passa a ser serializada
@JsonSerializable()
class CategoryModel {
  String title;
  String id;

  @JsonKey(defaultValue: [])
  List<ItemModel> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  CategoryModel({
    required this.title,
    required this.id,
    required this.items,
    required this.pagination,
  });

  // fromJson
  // De json para a classe CategoryModel
  factory CategoryModel.fromJson(Map<String, dynamic> jsonnn) =>
      _$CategoryModelFromJson(jsonnn);

  // toJson
  // Da classe CategoryModel para json(para Map<>)
  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);

  @override
  String toString() {
    return 'CategoryModel(title: $title, id: $id, items: $items, pagination: $pagination)';
  }
}
