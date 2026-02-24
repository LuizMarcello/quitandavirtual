import 'package:greengrocer/src/models/item_model.dart';

class CartItemModel {
  ItemModel itttem;
  int quantity;

  CartItemModel({required this.itttem, required this.quantity});

  double totalPrice() => itttem.price * quantity;
}
