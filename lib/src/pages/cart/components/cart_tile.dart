import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/pages/commom_widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

// Cada item do carrinho

class CartTile extends StatefulWidget {
  const CartTile({super.key, required this.cartItemmm, required this.removvve});

  // Estes foram inicializados no construtor
  // Para usar este componente, estes serão
  // parâmetros enviados
  final CartItemModel cartItemmm;
  final Function(CartItemModel) removvve;

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  // Este foi inicializado aqui mesmo
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        // imagem
        leading: Image.asset(
          widget.cartItemmm.itttem.imgUrl,
          height: 60,
          width: 60,
        ),

        // titulo
        title: Text(
          widget.cartItemmm.itttem.itemName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        // total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItemmm.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Botão quantidade
        trailing: QuantityWidget(
          valuuue: widget.cartItemmm.quantity,
          suffixTexxxt: widget.cartItemmm.itttem.unit,
          resulttt: (quantity) {
            setState(() {
              widget.cartItemmm.quantity = quantity;

              if (quantity == 0) {
                // Remover item do carrinho
                widget.removvve(widget.cartItemmm);
              }
            });
          },
          isRemovable: true,
        ),
      ),
    );
  }
}
