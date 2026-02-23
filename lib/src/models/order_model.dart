import 'package:greengrocer/src/models/cart_item_model.dart';

class OrderModel {
  String id;
  String status;
  String copyAndPaste;
  DateTime createdDateTime;
  DateTime overdueDateTime;
  double total;
  List<CartItemModel> items;

  OrderModel({
    required this.id,
    required this.status,
    required this.copyAndPaste,
    required this.createdDateTime,
    required this.overdueDateTime,
    required this.total,
    required this.items,
  });
}
