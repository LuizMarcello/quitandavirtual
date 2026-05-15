// cart_repository.dart: Esta classe se comunica com o backend
import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
// import 'package:greengrocer/src/models/cart_item_model.dart';
// import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class CartRepository {
  final _httpManager = HttpManager();

// Método de recuperação dos itens do carrinho
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

  // Método de alteração da quantidade
  // do item do produto no carrinho
  Future<bool> changeItemQuantity(
      {required String tttoken,
      required String cartIteeemId,
      required int quannntity}) async {
    final rrresult = await _httpManager.restRequest(
      urlll: EndPoints.changeItemQuantity,
      methoddd: HttpMethods.posttt,
      bodyyy: {
        'cartItemId': cartIteeemId,
        'quantity': quannntity,
      },
      headersss: {
        'X-Parse-Session-Token': tttoken,
      },
    );

// Condicional de maneira mais fácil:
// Se rrresult estiver vazio, retorna true,
// caso contrário, retorna false
    return rrresult.isEmpty;
  }

  // Método de adição de itens no carrinho
  Future<CartResult<String>> addItemToCart(
      {required String userId,
      required String token,
      required String productId,
      required int quantity}) async {
    final result = await _httpManager.restRequest(
      urlll: EndPoints.addItemToCart,
      methoddd: HttpMethods.posttt,
      bodyyy: {
        "user": userId,
        "quantity": quantity,
        "productId": productId,
      },
      headersss: {'X-Parse-Session-Token': token},
    );
    if (result['result'] != null) {
      // É diferente de nulo, adicionamos
      return CartResult<String>.success(result['result']['id']);
    } else {
      // Êrro
      return CartResult.error('Não foi possível adicionar o item no carrinho');
    }
  }
}
