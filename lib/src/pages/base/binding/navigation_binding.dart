import 'package:get/get.dart';
import 'package:greengrocer/src/pages/base/controller/navigation_controller.dart';

// Classe de conexão
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    // GetX:
    // Usando o lazyPut(Injetando na memória do dispositivo
    // uma instância do objeto NavigationController, somente
    // quando alguem precisar, através do "get.find", de
    // forma preguiçosa).
    Get.lazyPut(() => NavigationController());
  }
}
