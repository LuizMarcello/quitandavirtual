// Recuperando os dados vindos do json
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;

  @JsonKey(name: 'title')
  String itemName;

  @JsonKey(name: 'picture')
  String imgUrl;

  String unit;
  double price;
  String description;

  ItemModel({
    // required this.id,
    this.id = '',
    required this.itemName,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

// factory ItemModel.fromJson():
// É um construtor nomeado
// Usa factory porque não cria o objeto diretamente
// Delega a criação para outra função
// Map<String, dynamic> json:
// Representa o JSON vindo de uma API, por exemplo
// _ItemModelFromJson(json):
// Aqui está o segredo:
// Essa função não foi escrita por você
// Ela é gerada automaticamente pelo json_serializable
// Do Json vindo da api para o objeto ItemModel
  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  // Do objeto ItemModel para json, para enviar para a api
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, itemName: $itemName, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description)';
  }
}
