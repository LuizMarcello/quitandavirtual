import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String statuuus;
  final bool isOverduuue;

  const OrderStatusWidget({
    super.key,
    required this.statuuus,
    required this.isOverduuue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StatusDot(isActivvve: true, titllle: 'Teste de pagamento'),
        _StatusDot(isActivvve: false, titllle: 'Pagamento efetuado'),
      ],
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActivvve;
  final String titllle;

  const _StatusDot({required this.isActivvve, required this.titllle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Dot
        Container(
          alignment: Alignment.center,
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: CustomColors.customSwatchColor),

            color: isActivvve
                ? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: isActivvve
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : const SizedBox.shrink(),
        ),

        SizedBox(width: 5),

        //Texto
        Expanded(child: Text(titllle)),
      ],
    );
  }
}
