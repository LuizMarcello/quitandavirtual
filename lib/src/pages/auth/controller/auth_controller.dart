import 'package:get/get.dart';
import 'package:greengrocer/src/config/app_data.dart';
import 'package:greengrocer/src/constants/storage_keys.dart';
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

  // onInit: Método do GetX Controller, ele é
  // chamado sempre que instanciamos a classe
  // que herda do GetXController (acima, no
  // inicio desta classe). Parecido com o initState.
  // Esta classe AuthController está sendo instanciada
  // no main.dart, linha 19: Get.put(AuthController()).
  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    // Recuperar o token que foi salvo localmente
    // na primeira vêz que logou com este usuário,
    // e passando este token como parâmetro para
    // este token ser válidado, para sessões futuras
    String? toooken =
        await utilsServices.getLocalData(kkkey: StorageKeys.tokennn);

    // Verificação condicional
    // Se o token for nulo, não existir ainda,
    // possivelmente ainda não houve nenhuma
    // autenticação anterior deste usuário
    if (toooken == null) {
      // Então vai para a tela de logar
      Get.offAllNamed(PagesRoutes.signInRoute);
      // Este método morre aqui
      return;
    }
    AuthResult resulllt = await authRepository.validateToken('toooken');

    resulllt.when(success: (user) {
      uuuser = user;
      saveTokenAndProcedToBase();
    }, error: (message) {
      signOut();
    });
  }

// Método para fazer logout
  Future<void> signOut() async {
// Zerar o user
    user = UserModel();
    uuuser = UserModel();

// Remover o token localmente
    await utilsServices.removeLocalData(keeey: StorageKeys.tokennn);

// Ir para o login
    Get.offAllNamed(PagesRoutes.signInRoute);
  }

// Método para salvar o token localmente
// e navegar para a tela base do app
  void saveTokenAndProcedToBase() {
    // Salvar o token
    // "!" no final do token: Confia, não será nulo
    utilsServices.saveLocalData(
        keyyy: StorageKeys.tokennn, dattta: uuuser.token!);
    // Ir para a tela base
    // Tela após autenticar com sucesso
    // offAllNamed: Método do GetX que retira todas
    // as classes(outras telas) da base, e adiciona
    // esta próxima tela "baseRoute": Criado na classe
    // PagesRoutes
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

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
        saveTokenAndProcedToBase();
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
