// Esta é a classe que se comunica com o backend
import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  // Método para recuperar todas as categorias
  // Um Future<> Requisição assíncrona
  // Retorno tipo HomeResult<CategoryModel>
  // Assim, a lista resultante do HomeResult
  // será do tipo "CategoryModel"
  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
        urlll: EndPoints.getAllCategories, methoddd: HttpMethods.posttt);
    // O backend retorna um "result" quando está tudo OK
    if (result['result'] != null) {
      // Lista de categorias
      // Transformando de Map<> para classe CategoryModel
      // Retornando uma lista tipo CategoryModel
      List<CategoryModel> data =
          // (result['result'] as List<Map<String, dynamic>>)
          // Outro jeito de fazer:
          // Convertendo "result['result']" para o tipo "List<Map<String, dynamic>>"
          // e transforme cada item da mesma em um "CategoryModel"
          // O .map devolve um Iterable; o .toList() vira List<CategoryModel>
          // item a item, que é o tipo da variável "data" logo acima.
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();
      return HomeResult<CategoryModel>.success(data);
    } else {
      // Êrro
      return HomeResult.error(
          'Ocorreu um êrro inesperado ao recuperar as categorias');
    }
  }

  // Método para recuperar os produtos, por categorias
  // Retorno tipo HomeResult<ItemModel>
  // Assim, a lista resultante do HomeResult
  // será do tipo "ItemModel"
  // Este método "getAllProducts", tem como
  // parâmetro um Map<String, dynamic>
  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> bodddy) async {
    final result = await _httpManager.restRequest(
        urlll: EndPoints.getAllProducts,
        methoddd: HttpMethods.posttt,
        bodyyy: bodddy);

    // Na resposta, se tiver a chave "result", então tem dados
    // Este "result" é entendido como "dynamic"
    if (result['result'] != null) {
      // Retendo nesta lista "data", toda a
      // listagem de produtos vindo do backend
      // Convertendo "result['result']" para o tipo "List<Map<String, dynamic>>"
      // e convertendo posteriormente o tipo "List<Map<String, dynamic>>
      // para o tipo List<ItemModel>, através do ".map(ItemModel.fromJson))"
      // O .map devolve um Iterable; o .toList() vira List<ItemModel>,
      // que é o tipo da variável data.
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um êrro inesperado ao recuperar os itens');
    }
  }
}
