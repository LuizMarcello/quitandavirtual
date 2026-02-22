import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/cart/cart_tab.dart';
import 'package:greengrocer/src/pages/home/home_tab.dart';
import 'package:greengrocer/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndexxx = 0;

  // Criando o controlador do pageView
  final pageControllerrr = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
        /// Travando para não alterar entre as telas, com o mouse
        physics: const NeverScrollableScrollPhysics(),
        controller: pageControllerrr,
        children: [
          const HomeTab(),
          const CartTab(),
          Container(color: Colors.blue),
          const ProfileTab(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndexxx,
        onTap: (index) {
          setState(() {
            currentIndexxx = index;
            pageControllerrr.jumpToPage(index);
          });
        },

        type: BottomNavigationBarType.fixed,

        /// backgroundColor da bottomNavigationBar
        backgroundColor: Colors.green,

        /// Mudando a cor do BottomNavigationBarItem selecionado
        selectedItemColor: Colors.white,

        /// As cores dos BottomNavigationBarItem não-selecionados
        unselectedItemColor: Colors.white.withAlpha(100),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carrinho',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Pedidos'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
