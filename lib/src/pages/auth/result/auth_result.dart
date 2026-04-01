import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greengrocer/src/models/user_model.dart';
// Classe responsável por conter os resultados
// Data Matching” (Pattern Matching) com Freezed
// Classe responsável por conter os dois possíveis resultados
// para os métodos "signIn()" e "signUp()", da classe
// auth_repository.dart

// Classe auto gerada
part 'auth_result.freezed.dart';

// Comando para executar: flutter pub run build_runner build

@freezed
class AuthResult with _$AuthResult {
  // Sucesso: Vai retornar um objeto do usuário
  factory AuthResult.success(UserModel user) = Success;
  // Falha: Vai retornar mensagem de êrros
  factory AuthResult.error(String message) = Error;
}
