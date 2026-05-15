import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_in_screen.dart';
import 'package:greengrocer/src/pages/auth/view/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/binding/navigation_binding.dart';
import 'package:greengrocer/src/pages/cart/binding/cart_binding.dart';
import 'package:greengrocer/src/pages/home/binding/home_binding.dart';
import 'package:greengrocer/src/pages/product/product_screen.dart';
import 'package:greengrocer/src/pages/splash/splash_screen.dart';

// Esta classe AppPages, trata da listagem
// via GetX, das telas do APP
abstract class AppPages {
  // Uma lista de GetPages(GetX)
  static final pages = <GetPage>[
    // Instâncias do tipo GetPage(GetX)
    GetPage(name: PagesRoutes.productRoute, page: () => ProductScreen()),
    GetPage(name: PagesRoutes.splashRoute, page: () => const SplashScreen()),
    GetPage(name: PagesRoutes.signInRoute, page: () => SignInScreen()),
    GetPage(name: PagesRoutes.signUpRoute, page: () => SignUpScreen()),
    GetPage(
      page: () => const BaseScreen(),
      name: PagesRoutes.baseRoute,
      bindings: [
        // Indicando para esta classe NavigationBinding
        // entrar em ação e injetar na memória do dispositivo
        // o objeto NavigationController
        NavigationBinding(),
        // Indicando para esta classe HomeBinding entrar
        // em ação e injetar na memória do dispositivo o
        // objeto HomeController
        HomeBinding(),
        // Indicando para esta classe CartBinding entrar
        // em ação e injetar na memória do dispositivo o
        // objeto CartController
        CartBinding(),
      ],
    )
  ];
}

abstract class PagesRoutes {
  static const String productRoute = '/product';
  static const String signInRoute = '/signin';
  static const String signUpRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String baseRoute = '/';
}
