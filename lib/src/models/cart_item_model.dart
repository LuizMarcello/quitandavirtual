import 'package:json_annotation/json_annotation.dart';
import 'package:greengrocer/src/models/item_model.dart';

// Classe responsável pelos itens do carrinho.

// Recebendo em json e transformando em um objeto
// Classe auto-gerada pelo json serializable
part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: 'product')
  ItemModel itttem;
  // id do item do carrinho
  String id;
  int quantity;

  CartItemModel({
    required this.itttem,
    required this.id,
    required this.quantity,
  });

// Usa factory porque não cria o objeto diretamente,
// delega a criação para outra função.
// Map<String, dynamic> json:
// Representa o JSON vindo, por exemplo, de uma API.
// _$CartItemModelFromJson(json):
// Aqui está o segredo, essa função não foi escrita por você,
// ela é gerada automaticamente pelo json_serializable.
// Do Json vindo da api para o objeto CartItemModel.
  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

// Do objeto CartItemModel para json, para enviar para a API
// _$CartItemModelToJson(): Método auto-gerado pelo json_serializable
  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  double totalPrice() => itttem.price * quantity;

  @override
  String toString() =>
      'CartItemModel(itttem: $itttem, id: $id, quantity: $quantity)';
}
