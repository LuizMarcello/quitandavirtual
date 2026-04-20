import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_result.freezed.dart';

@freezed
class HomeResult<T> with _$HomeResult<T> {
  // Em caso de sucesso
  // <T>: genérics
  factory HomeResult.success(List<T> data) = Success;
  // Em caso de êrro
  factory HomeResult.error(String message) = Error;
}
