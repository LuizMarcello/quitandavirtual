import 'package:get/get.dart';

// Gerencia de estados das telas de "signIn" e "signUp"
class AuthController extends GetxController {
// Variável observável "isLoooading", se a
// tela está carregando ou não
// Valor inicial "false".
  RxBool isLoooading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
// Pegando o valor da variável isLoooading
    isLoooading.value = true;

// Este delay é como se estive fazendo a requisição no backend
    await Future.delayed(Duration(seconds: 4));

    isLoooading.value = false;
  }
}
