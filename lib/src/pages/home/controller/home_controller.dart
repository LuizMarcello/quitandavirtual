import 'package:get/get.dart';
import 'package:greengrocer/src/models/category_model.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/repository/home_repository.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';
import 'package:greengrocer/src/services/utils_services.dart';

const int itemsPerPage = 6;

/// Controlador GetX da aba(tela) inicial (home).
/// Centraliza estado e lógica da [HomeTab]
class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utilsServices = UtilsServices();

  // Usando "GetBuilder""
  // Não precisa de variáveis observáveis
  // IsLoading das categorias
  bool isCategoryLoading = false;
  // IsLoading dos produtos
  bool isProductLoading = true;

  // Será a lista das categorias
  List<CategoryModel> allCategories = [];
  // Será a categoria selecionada
  CategoryModel? currentCategory;
  // Obtendo os itens da categoria corrente
  // No Dart, "get" serve pra criar uma propriedade calculada
  // (um “atributo que executa código”).
  List<ItemModel> get allProductsss => currentCategory?.items ?? [];

  // No GetX existem dois principais:
// 🟢 GetBuilder
// manual (update())
// mais performático
// mais simples
// 🔵 Obx
// automático (reativo)
// usa .obs
// atualiza sozinho

// Método par alterar o estado das variáveis
// isCategoryLoading e isProductLoading
// O 2º parâmetro é nomeado e opcional
  void setLoading(bool value, {bool isProduct = false}) {
    if (!isProduct) {
      isCategoryLoading = value;
    } else {
      isProductLoading = value;
    }
    // Sempre que update() é chamado, o getBuilder
    // é acionado e o widget reconstrói
    update();
  }

  // GetX onInit()
  // Como se fosse o initState normal
  // Assim, executando o getAllCategories()
  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(CategoryModel category) {
    currentCategory = category;
    // Reconstrói GetBuilder cada vêz que é chamado
    update();

    // Se já existem produto(s) nesta lista de
    // categorias, então ela já buscou no backend
    // então não precisa buscar de novo
    if (currentCategory!.items.isNotEmpty) return;

// Obtendo todos os produtos da referida categoria
    getAllProducts();
  }

// Método para obter as categorias
  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<CategoryModel> homeResult =
        await homeRepository.getAllCategories();
    setLoading(false);

// homeResult(freezed): Recuperando os estados possíveis de
// receber através desta requisição de recuperação
// de todas categorias
    homeResult.when(
      // data: Uma lista de categorias
      success: (data) {
        // assignAll: Se esta lista já tivesse
        // itens, seriam substituidos
        allCategories.assignAll(data);

        if (allCategories.isEmpty) return;

        selectCategory(allCategories.first);
      },
      error: (message) {
        utilsServices.showToast(messssage: message, isErrooor: true);
      },
    );
  }

// Método para obter os produtos da categoria
  Future<void> getAllProducts() async {
    setLoading(true, isProduct: true);

    Map<String, dynamic> body = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      "itemsPerPage": itemsPerPage
    };

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(body);
    setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        currentCategory!.items = data;
      },
      error: (message) {
        utilsServices.showToast(
          messssage: message,
          isErrooor: true,
        );
      },
    );
  }
}
