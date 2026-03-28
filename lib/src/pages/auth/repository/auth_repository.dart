import 'package:greengrocer/src/constants/endpoints.dart';
// ignore: library_prefixes
import 'package:greengrocer/src/pages/auth/repository/auth_errors.dart' as authErrorsss;
import 'package:greengrocer/src/pages/auth/result/auth_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';
import 'package:greengrocer/src/models/user_model.dart';

class AuthRepository {
  final HttpManager _httpManager = HttpManager();

// Os retornos possíveis deste Future<>() estáo na classe auth_result.dart
  Future<AuthResult> signIn(
      {required String emailll, required String passworddd}) async {
    final resuuult = await _httpManager.restRequest(
      urlll: EndPoints.signin,
      methoddd: HttpMethods.posttt,
      bodyyy: {
        "email": emailll,
        "password": passworddd,
      },
    );

// Qualquer reposta do backend que tiver a chave
// 'result', terá dado tudo certo na requisição
    if (resuuult['result'] != null) {
// Instanciando um novo usuário
// Em caso de sucesso: Retornando um objeto UserModel,
// através da classe AuthResult (Data Matching (Pattern Matching)
// com Freezed)

      final user = UserModel.fromJson(resuuult['result']);
      return AuthResult.success(user);
    } else {
      // Em caso de êrro: Retornando mensagens
      // através da classe AuthResult (Data Matching
      //  (Pattern Matching) com Freezed)

      return AuthResult.error(authErrorsss.authErrorsString(resuuult['error']));
    }
  }
}
