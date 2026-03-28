import 'package:dio/dio.dart';

// Este arquivo é o gerenciador de requisições Rest do backend

abstract class HttpMethods {
  static const String posttt = 'POST';
  static const String gettt = 'GET';
  static const String puttt = 'PUT';
  static const String deleteee = 'DELETE';
  static const String patchhh = 'PATCH';
}

class HttpManager {
  Future<Map> restRequest({
    required String urlll,
    required String methoddd,
    Map? headersss,
    Map? bodyyy,
  }) async {
// Headers da requisição
// Caso "headersss" seja nulo(?), será
// atribuido(??) o "{}" a "defaultHeaders"
    final defaultHeaders = headersss?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
        'X-Parse-Application-Id': 'wK7GcEjr2V4br5q5mlR1kybQ5dvxMFDX0qtE1d6Y',
        'X-Parse-REST-API-Key': '2kahi62fkWePLWAwC7k8aMrtQkobogcgkruMxbeB',
      });

    Dio diooo = Dio();

    try {
      Response responseee = await diooo.request(
        urlll,
        options: Options(headers: defaultHeaders, method: methoddd),
        // data: Enviando um dado(o body) para o Dio
        data: bodyyy,
      );
      // Retorno do resultado do server(Backend)
      return responseee.data;
    } on DioException catch (error) {
      // Retôrno do êrro do Dio request
      // Se response for nullo, retorna um Map<> vazio
      return error.response?.data ?? {};

// Erros onde o statusCode não apresenta sucesso
    } catch (error) {
      // Se acontecer algum outro êrro qualquer,
      // não esperado, não relacionado ao Dio(),
      // algum êrro generalizado, daí
      // retorna um Map<> vazio
      return {};
    }
  }
}
