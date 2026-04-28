import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class NavigationTabs {
  static const int home = 0;
  static const int cart = 1;
  static const int orders = 2;
  static const int profile = 3;
}

// Classe controladora tipo GetX, para controlar a navegação
class NavigationController extends GetxController {
  late PageController _pageController;
  // Variável observável do GetX
  late RxInt _currentIndex;

  // Usando "getters":
  PageController get pageController => _pageController;
  int get currentIndex => _currentIndex.value;

  // 1º método que é chamdo quando esta classe é instanciada
  // Seria o mesmo que o initState normal
  // Método Getx:
  @override
  void onInit() {
    super.onInit();
    _initNavigation(
      pageController: PageController(initialPage: NavigationTabs.home),
      currentIndex: NavigationTabs.home,
    );
  }

  // Método de inicialização da navegação
  // Instanciando esta classe
  void _initNavigation({
    required PageController pageController,
    required int currentIndex,
  }) {
    _pageController = pageController;
    _currentIndex = currentIndex.obs;
  }

  // Método responsável por fazer a paginação
  void navigatePageView(int page) {
    // Se já estivermos na página citada
    if (_currentIndex.value == page) return;

    _pageController.jumpToPage(page);
    // .value: è observável
    _currentIndex.value = page;
  }
}
