import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class QuantityWidget extends StatelessWidget {
  final int valuuue;
  final String suffixTexxxt;
  final Function(int quantity) resulttt;
  final bool? isRemovable;

  const QuantityWidget({
    super.key,
    required this.valuuue,
    required this.suffixTexxxt,
    required this.resulttt,
    this.isRemovable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // InkWell: Fazendo o container clicável
          _QuantityButton(
            icon: !isRemovable! || valuuue > 1
                ? Icons.remove
                : Icons.delete_forever,
            color: !isRemovable! || valuuue > 1 ? Colors.grey : Colors.red,
            onPressed: () {
              // Se for verdadeiro, o código
              // abaixo não será executado
              if (valuuue == 1 && !isRemovable!) return;

              int resultCount = valuuue - 1;
              resulttt(resultCount);
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              '$valuuue$suffixTexxxt',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),

          _QuantityButton(
            icon: Icons.add,
            color: CustomColors.customSwatchColor,
            onPressed: () {
              int resultCount = valuuue + 1;
              resulttt(resultCount);
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  // VoidCallback: Sem parametro e sem retôrno
  final VoidCallback onPressed;

  const _QuantityButton({
    required this.color,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onPressed,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
      ),
    );
  }
}
