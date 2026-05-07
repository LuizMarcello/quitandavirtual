import 'package:freezed_annotation/freezed_annotation.dart';

// Classe auto gerada
part 'cart_result.freezed.dart';

@freezed
// Classe responsável por conter os resultados
// Data Matching” (Pattern Matching) com Freezed
// Classe responsável por conter os dois possíveis resultados
// para os métodos "getCartItems()", da classe
// cart_repository.dart
class CartResult<T> with _$CartResult<T> {
  factory CartResult.success(T data) = Success;
  factory CartResult.error(String message) = Error;
}