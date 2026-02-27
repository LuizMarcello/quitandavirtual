import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
// import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/cart/components/cart_tile.dart';
import 'package:greengrocer/src/pages/commom_widgets/payment_dialog.dart';
import 'package:greengrocer/src/services/utils_services.dart';
// ignore: library_prefixes
import 'package:greengrocer/src/config/app_data.dart' as appData;

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();

  void removeItemFromCart(CartItemModel cartItem) {
    setState(() {
      appData.cartItems.remove(cartItem);
    });
  }

  double cartTotalPrice() {
    double total = 0;
    for (var item in appData.cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      // Este placeholder é apenas provisório
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: appData.cartItems.length,
              itemBuilder: (_, index) {
                // Aqui agora, usando o componente "cartTile"
                // para fazer parte deste tela, e passando
                // pra ele o item do produto mostrado
                return CartTile(
                  cartItemmm: appData.cartItems[index],
                  removvve: removeItemFromCart,
                );
                // appData.cartItems[index].item.itemName)
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Total Geral', style: TextStyle(fontSize: 12)),
                Text(
                  utilsServices.priceToCurrency(cartTotalPrice()),
                  style: TextStyle(
                    fontSize: 23,
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.customSwatchColor,
                      // backgroundColor: CustomColors.customSwatchColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await showOrderConfirmation();

                      if (result ?? false) {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (_) {
                            return PaymentDialog(orddder: appData.orders.first);
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Concluir Pedido',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Retorno desta função Future: True ou false ou pode
  // retornar nulo (bool?), caso clique fora da janela
  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: const Text('Confirmação'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
