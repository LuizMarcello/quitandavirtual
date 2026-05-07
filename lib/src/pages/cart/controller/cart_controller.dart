import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  // Recuperando a instância do objeto AuthController da
  // memória do dispositivo, para ter acesso ao token
  // e userId do usuário autenticado.
  // Foi injetado no main.dart
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

// Esta lista "cartItennns", são os itens do carrinho
  List<CartItemModel> cartItennns = [];

  @override
  void onInit() {
    super.onInit();
// Quando esta classe "CartController" for instanciada, e injetada
// na memória, este método "getCartItems()" será executado
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    // Recuperando cada item da listagem dos itens do carrinho
    for (final item in cartItennns) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<void> getCartItems() async {
    // Esta variável "resuuult" estará contendo o que
    // o método "getCartItens" da classe "CartRepository"
    // retornar. Será usada para mostrar os itens na tela,
    // através da classe cart_tab.dart
    final CartResult<List<CartItemModel>> resuuult =
        await cartRepository.getCartItems(
      tokeeen: authController.uuuser.token!,
      userId: authController.uuuser.id!,
    );
    resuuult.when(
      success: (data) {
        // Setando os dados recebidos para a
        // lista dos itens do carrinho
        cartItennns = data;
        // Widget especial do GetX que fará a reatividade
        // da lista dos itens do carrino sendo apresentados
        update();
      },
      error: (message) {
        utilsServices.showToast(
          messssage: message,
          isErrooor: true,
        );
      },
    );
  }
}
