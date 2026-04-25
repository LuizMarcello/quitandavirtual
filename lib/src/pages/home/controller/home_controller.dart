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

  // Variável observável tipo String, para usar no
  // campo de pesquisa de produtos, pelo título
  RxString searchTitle = ''.obs;

// Getter para saber se já está na última página do backend, ou não
  bool get isLastPageee {
    // Na verdade, estas duas lógicas definem se é a última pagina
    // Se o tamanho da lista de items desta categoria...
    // Se retornar true, sim, é a última página
    if (currentCategory!.items.length < itemsPerPage) return true;
    return currentCategory!.pagination * itemsPerPage > allProductsss.length;
  }

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
  // onInit(): Método que é iniciado sempre que
  // instanciamos esta classe controladora do GetX
  @override
  void onInit() {
    super.onInit();

    // debounce: Método do Getx
    // Vai ficar observando a variável observável
    // searchTitle, sempre que ela for modificada,
    // vai ser feito alguma coisa na arrow-function
    debounce(
      searchTitle,
      (_) => filterByTitle(),
      time: const Duration(milliseconds: 1200),
    );
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

  // allCategories: Todas as categorias
  // allProductsCategory: Todos os produtos de todas as categorias

// Método para pesquisar produtos pelo titulo
  void filterByTitle() {
// Inicialmente, apagar os produtos de todas as categorias
// Laço: Recuperando cada uma das categorias
// da lista de categorias
    for (var category in allCategories) {
      category.items.clear();
      category.pagination = 0;
    }

    // Verificando se o campo de pesquisas está vazio
    if (searchTitle.value.isEmpty) {
      // Se estiver vazio, removendo a lista "allProductsCategory"
      // do inicio da lista allCategories, da posição 0
      allCategories.removeAt(0);
    } else {
// Confirmando se "allProductsCategory(todos)" já
// não está presente na lista "AllCategories"
      CategoryModel? c = allCategories.firstWhereOrNull((cat) => cat.id == '');

// Se "c" for nulo, a allProductsCategory ainda não
// existe em "allCategories", então será criada
      if (c == null) {
        // Criando uma nova lista de categorias com
        // todos os produtos de todas as categorias
        final allProductsCategory = CategoryModel(
          title: 'Todos',
          id: '',
          items: [],
          pagination: 0,
        );

// Inserindo a lista "allProductsCategory"
// no inicio da lista "allCategories"
        allCategories.insert(0, allProductsCategory);
      } else {
        c.items.clear();
        c.pagination = 0;
      }
    }
// Fazendo com que a categoria atual selecionada
// seja atribuida a "allProductsCategory"
    currentCategory = allCategories.first;
// Atualizando o frontEnd
// Reconstrói GetBuilder cada vêz que é chamado
    update();
// Obtendo todos os produtos da referida categoria
    getAllProducts();
  }

  void loadMoreProducts() {
    currentCategory!.pagination++;
    getAllProducts(canLoad: false);
  }

// Método para obter todos os produtos da categoria
  Future<void> getAllProducts({bool canLoad = true}) async {
    if (canLoad) {
      setLoading(true, isProduct: true);
    }

    Map<String, dynamic> bodyyy = {
      'page': currentCategory!.pagination,
      'categoryId': currentCategory!.id,
      'itemsPerPage': itemsPerPage
    };

    // Este "value" é porque é uma variável observável
    if (searchTitle.value.isNotEmpty) {
      // Se o campo de pesquisa não estiver vazio,
      // acrescenta o campo "title" no Map<> bodyyy,
      // para ser usado na pesquisa
      bodyyy['title'] = searchTitle.value;

      // Se a categoria "todos" estiver selecionada,
      // será removida a categoria corrente atual
      if (currentCategory!.id == '') {
        bodyyy.remove('categoryId');
      }
    }

    HomeResult<ItemModel> result = await homeRepository.getAllProducts(bodyyy);
    setLoading(false, isProduct: true);

    result.when(
      success: (data) {
        // Assim, caso já tenha conteúdo nesta lista
        // de itens, será adicionado todos os outros
        // itens, vindos do backend
        currentCategory!.items.addAll(data);
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
