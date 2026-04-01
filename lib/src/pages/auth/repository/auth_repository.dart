import 'package:greengrocer/src/constants/endpoints.dart';
// ignore: library_prefixes
import 'package:greengrocer/src/pages/auth/repository/auth_errors.dart' as authErrorsss;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';
import 'package:greengrocer/src/models/user_model.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

  // Recebe Map<dynamic, dynamic> como parâmetro
  // Retorna um AuthResult
  AuthResult handleUserOrError(Map<dynamic, dynamic> rrresult) {
// Qualquer reposta do backend que tiver a chave
// 'result', terá dado tudo certo na requisição
    if (rrresult['result'] != null) {
// Instanciando um novo usuário
// Em caso de sucesso: Retornando um objeto UserModel,
// através da classe AuthResult (Data Matching (Pattern Matching)
// com Freezed)
      final user = UserModel.fromJson(rrresult['result']);
      return AuthResult.success(user);
    } else {
      // Em caso de êrro: Retornando mensagens
      // através da classe AuthResult (Data Matching
      //  (Pattern Matching) com Freezed)
      return AuthResult.error(authErrorsss.authErrorsString(rrresult['error']));
    }
  }

  // Método para validação do "token do usuário" autenticado
  // Se tudo der certo, vai devolver um objeto do usuário
  Future<AuthResult> validateToken(String token) async {
    final resulllt = await _httpManager.restRequest(
        urlll: EndPoints.validateToken,
        methoddd: HttpMethods.posttt,
        headersss: {
          'X-Parse-Session-Token': token,
        });
    return handleUserOrError(resulllt);
  }

// Os retornos possíveis deste Future<>() estáo na classe auth_result.dart
  Future<AuthResult> signIn(
      {required String emailll, required String passworddd}) async {
    final resuuult = await _httpManager.restRequest(
      urlll: EndPoints.signin,
      methoddd: HttpMethods.posttt,
      bodyyy: {
        'email': emailll,
        'password': passworddd,
      },
    );
    return handleUserOrError(resuuult);
  }

  // Método para cadastro de um novo usuário do app
  // Os retornos possíveis deste Future<>() estão na classe auth_result.dart
  Future<AuthResult> signUp(UserModel user) async {
    final resulttt = await _httpManager.restRequest(
      urlll: EndPoints.signup, methoddd: HttpMethods.posttt,
      // Este toJson() retorna um Map<String, dynamic>
      bodyyy: user.toJson(),
    );
    return handleUserOrError(resulttt);
  }
}
