import 'package:get/get.dart';
import 'package:greengrocer/src/pages/cart/controller/cart_controller.dart';

// Classe de conexão
// Este "CartBindig" vai injetar na memória do dispositivo
// uam instância do objeto "CartController", mas não quando
// o aplicativo iniciar, não quando estiver no processo de
// autenticação, mas sim, quando já tenha passado da
// autenticação, já tenha adentrado na aplicação, daí
// sim, que ele injete este objeto.
// Será recuperado através do "get.find", quando
// alguem precisar
class CartBinding extends Bindings {
  @override
  void dependencies() {
    // GetX:
    Get.put(CartController());
  }
}
