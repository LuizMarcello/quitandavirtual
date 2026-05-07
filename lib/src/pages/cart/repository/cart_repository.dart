// cart_repository.dart: Esta classe se comunica com o backend
import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
// import 'package:greengrocer/src/models/cart_item_model.dart';
// import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String tokeeen, required String userId}) async {
    final resulllt = await _httpManager.restRequest(
        urlll: EndPoints.getCartItems,
        methoddd: HttpMethods.posttt,
        headersss: {
          'X-Parse-Session-Token': tokeeen,
        },
        bodyyy: {
          'user': userId,
        });
    if (resulllt['result'] != null) {
      // Tratar, caso tenhamos dados.
      // No fim, "data" vira uma lista: "List<CartItemModel>""
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(resulllt['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      // retornar uma mensagem
      return CartResult.error(
          'Ocorreu um êrro ao recuperar os itens do carrinho');
    }
  }
}
