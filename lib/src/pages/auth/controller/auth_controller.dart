import 'package:get/get.dart';
import 'package:greengrocer/src/models/user_model.dart';
import 'package:greengrocer/src/pages/auth/repository/auth_repository.dart';
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';

// Esta é a classe controladora do "GetX"
// Gerenciador de estados das telas de "signIn" e "signUp"
class AuthController extends GetxController {
// Variável observável "isLoooading", se a
// tela está carregando ou não
// Valor inicial "false".
  RxBool isLoooading = false.obs;

// Injetando "AuthRepository" aqui
  final authRepository = AuthRepository();

  // Injetando UtilsServices aqui
  final utilsServices = UtilsServices();

  // Tendo um objeto de usuário salvo aqui nesta classe
  UserModel uuuser = UserModel();

  Future<void> signIn({required String email, required String password}) async {
// Pegando o valor da variável isLoooading
    isLoooading.value = true;

// Este delay é como se estive fazendo a requisição no backend
    // await Future.delayed(Duration(seconds: 4));

// Este método Future "signIn()"" da classe auth_repository.dart,
// consegue retornar algo por estar usando a classe AuthResult
// (Data Matching (Pattern Matching) com Freezed).
    AuthResult result =
        await authRepository.signIn(emailll: email, passworddd: password);

    isLoooading.value = false;

// Este result é do tipo AuthResult
    result.when(
      success: (user) {
        // O "this" está referenciando um atributo desta classe "AuthController"
        uuuser = user;

        // Tela após autenticar com sucesso
        // offAllNamed: Método do GetX que retira todas
        // as classes(outras telas) da base, e adiciona
        // esta próxima tela "baseRoute": Criado na classe
        // PagesRoutes
        Get.offAllNamed(PagesRoutes.baseRoute);
      },
      error: (messaaaage) {
        // showToast: Mensagens rápidas
        utilsServices.showToast(
          messssage: messaaaage,
          isErrooor: true,
        );
      },
    );
  }
}
