import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/models/user_model.dart';

ItemModel apple = ItemModel(
  itemName: 'Maçã',
  imgUrl: 'assets/fruits/apple.png',
  unit: 'kg',
  price: 5.5,
  description: 'Melhor mação da região',
);

ItemModel grape = ItemModel(
  imgUrl: 'assets/fruits/grape.png',
  itemName: 'Uva',
  price: 7.4,
  unit: 'kg',
  description:
      'A melhor uva da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel guava = ItemModel(
  imgUrl: 'assets/fruits/guava.png',
  itemName: 'Goiaba',
  price: 11.5,
  unit: 'kg',
  description:
      'A melhor goiaba da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel kiwi = ItemModel(
  imgUrl: 'assets/fruits/kiwi.png',
  itemName: 'Kiwi',
  price: 2.5,
  unit: 'un',
  description:
      'O melhor kiwi da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel mango = ItemModel(
  imgUrl: 'assets/fruits/mango.png',
  itemName: 'Manga',
  price: 2.5,
  unit: 'un',
  description:
      'A melhor manga da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

ItemModel papaya = ItemModel(
  imgUrl: 'assets/fruits/papaya.png',
  itemName: 'Mamão papaya',
  price: 8,
  unit: 'kg',
  description:
      'O melhor mamão da região e que conta com o melhor preço de qualquer quitanda. Este item conta com vitaminas essenciais para o fortalecimento corporal, resultando em uma vida saudável.',
);

// Lista de produtos
List<ItemModel> items = [apple, grape, guava, kiwi, mango, papaya];

final List<String> categoriesss = [
  'Frutas',
  'Grãos',
  'Verduras',
  'Temperos',
  'Cereais',
];

List<CartItemModel> cartItems = [
  CartItemModel(itttem: apple, quantity: 1),
  CartItemModel(itttem: mango, quantity: 1),
  CartItemModel(itttem: guava, quantity: 3),
];

UserModel user = UserModel(
  name: 'João Pedro',
  email: 'joaopedro@gmail.com',
  phone: '9 9999 9999',
  cpf: '999.999.999-99',
  password: '',
);

List<OrderModel> orders = [
  // Pedido 01 com 2 itens
  OrderModel(
    id: 'kdjlskdj89d8',
    status: 'pending_payment',
    // status: 'preparing_purchase',
    copyAndPaste: 's9dsd9sd9s9d',
    createdDateTime: DateTime.parse('2026-06-08 10:00:10.458'),
    overdueDateTime: DateTime.parse('2026-06-08 11:00:10.458'),
    total: 11.0,
    itemsss: [
      CartItemModel(itttem: apple, quantity: 2),
      CartItemModel(itttem: mango, quantity: 3),
    ],
  ),

  // Pedido 02 com 1 item
  OrderModel(
    id: '4lk4l4l4jj',
    // status: 'pending_payment',
    status: 'delivered',
    // status: 'refunded',
    copyAndPaste: '4lk4l4l4jj',
    createdDateTime: DateTime.parse('2026-06-08 10:00:10.458'),
    overdueDateTime: DateTime.parse('2026-06-08 11:00:10.458'),
    total: 11.0,
    itemsss: [
      CartItemModel(itttem: apple, quantity: 2),
    ],
  ),
];
