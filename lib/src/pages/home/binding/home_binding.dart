import 'package:get/get.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';

// Herdando a classe Binding do GetX
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Injeção de dependências: Injetando uma instância do
    // HomeController na memória do dispositivo, para que
    // depois possa acessá-lo de qualquer lugar do app.
    // Usando aqui o Get(GetX)
    Get.put(HomeController());
  }
}
