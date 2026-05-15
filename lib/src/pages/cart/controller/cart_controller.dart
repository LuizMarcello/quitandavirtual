import 'package:get/get.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
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

// Método para alterar a quantidade de um item no carrinho
// Através do método "cart_repository.changeItemQuantity()"
  Future<bool> changeItemQuantity({
    required CartItemModel itttem,
    required int quuuantity,
  }) async {
    final result = await cartRepository.changeItemQuantity(
      tttoken: authController.uuuser.token!,
      cartIteeemId: itttem.id,
      quannntity: quuuantity,
    );
    return result;
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

  // Método que retorna um index específico deste
  // produto, da lista de itens do produto, para
  // saber se realmente ele existe na lista, para
  // então alterar a sua quantidade
  // Retorna um inteiro referente ao index, ou se
  // não encontrar, retorna -1 (não existe o index)
  int getItemIndex(ItemModel iiitem) {
    return cartItennns
        .indexWhere((itemInList) => itemInList.itttem.id == iiitem.id);
  }

  // Método para adicionar novos itens no carrinho
  Future<void> addItemToCart(
      {required ItemModel itttem, int quantiiity = 1}) async {
    // Recuperando o index deste produto adicionado
    int itemIndex = getItemIndex(itttem);

    if (itemIndex >= 0) {
      // Já existe o item na listagem de itens
      // Então, só vai ser alterada sua quantidade
      // Se ele já existe, vamos recuperar este produto na
      // listagem de itens do carrinho, e vamos alterar
      // sua quantidade no backend
      // Aqui, temos o produto recuperado
      final product = cartItennns[itemIndex];

      final rrresult = await changeItemQuantity(
          itttem: product, quuuantity: (product.quantity + quantiiity));

      if (rrresult) {
        cartItennns[itemIndex].quantity += quantiiity;
      } else {
        utilsServices.showToast(
            messssage: 'Ocorreu um êrro ao alterar a quantidade do produto!',
            isErrooor: true);
      }
    } else {
      // Ainda não existe o item na listagem de itens do carrinho
      // Criando a variável "resuuult", que contém o retôrno
      // de cartRepository.addItemToCart(), um CartResult<String>:
      // success com o id em texto do item(novo produto) criado no
      // servidor, dos itens adicionados no carrinho
      final CartResult<String> resuuult = await cartRepository.addItemToCart(
        userId: authController.uuuser.id!,
        token: authController.uuuser.token!,
        productId: itttem.id,
        quantity: quantiiity,
      );

      resuuult.when(
        success: (cartItemId) {
          // Se conseguindo adicionar o item no carrinho
          // add: Adicionando então este novo item do carrinho
          // na lista dos itens do carrinho, através de uma nova
          // instância de CartItemModel
          cartItennns.add(
            CartItemModel(
              itttem: itttem,
              id: cartItemId,
              quantity: quantiiity,
            ),
          );
        },
        // Se não conseguindo adicionar o item no carrinho
        error: (message) {
          utilsServices.showToast(
            messssage: message,
            isErrooor: true,
          );
        },
      );
    }
    update();
  }
}
