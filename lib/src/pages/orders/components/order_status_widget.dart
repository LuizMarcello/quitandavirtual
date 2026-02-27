import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class OrderStatusWidget extends StatelessWidget {
  final String statuuus;
  final bool isOverduuue;

  // Map com todos os status do pedido
  // Map(dicionário) que converte "status em texto" → "número inteiro"
  final Map<String, int> allStatus = <String, int>{
    'pending_payment': 0,
    'refunded': 1,
    'paid': 2,
    'preparing_purchase': 3,
    'shipping': 4,
    'delivered': 5,
  };

  // getter para obter o status atual em formato numérico.
  // "statuuus" é uma das strings do Map<> acima, e então
  // "allStatus" retorna o inteiro relativo a esta string.
  int get currentStatus => allStatus[statuuus]!;

  OrderStatusWidget({
    super.key,
    required this.statuuus,
    required this.isOverduuue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Sem condicional, vai aparecer sempre
        const _StatusDot(isActivvve: true, titllle: 'Pedido confirmado'),
        const _CustomDivider(),
        // Spread Operator(...): Desempacota uma lista
        // (ou map, ou set) dentro de outra. No caso,
        // dentro da Column() acima
        // if (currentStatus == 1)
        // const _StatusDot(isActivvve: true, titllle: 'Pix estornado'),
        if (currentStatus == 1) ...[
          const _StatusDot(
            isActivvve: true,
            titllle: 'Pix estornado',
            backgroundColor: Colors.orange,
          ),
        ] else if (isOverduuue) ...[
          const _StatusDot(
            isActivvve: true,
            titllle: 'Pagamento do Pix vencido',
            backgroundColor: Colors.red,
          ),
        ] else ...[
          _StatusDot(isActivvve: currentStatus >= 2, titllle: 'Pagamento'),
          const _CustomDivider(),
          _StatusDot(isActivvve: currentStatus >= 3, titllle: 'Preparando'),
          const _CustomDivider(),
          _StatusDot(isActivvve: currentStatus >= 4, titllle: 'Envio'),
          const _CustomDivider(),
          _StatusDot(isActivvve: currentStatus == 5, titllle: 'Entregue'),
        ],
      ],
    );
  }
}

// Divisão vertical entre os dots |
class _CustomDivider extends StatelessWidget {
  const _CustomDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      height: 10,
      width: 2,
      color: Colors.grey.shade500,
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActivvve;
  final String titllle;
  final Color? backgroundColor;

  const _StatusDot({
    required this.isActivvve,
    required this.titllle,
    // ignore: unused_element_parameter
    this.backgroundColor,
  });

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

            // Se isActivvve for true:
            // → use backgroundColor se ele não for null
            // → senão use CustomColors.customSwatchColor
            // Se isActivvve for false:
            // → use Colors.transparent
            color: isActivvve
                ? backgroundColor ?? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: isActivvve
              ? const Icon(Icons.check, size: 13, color: Colors.white)
              : const SizedBox.shrink(),
        ),

        SizedBox(width: 5),

        //Texto
        Expanded(child: Text(titllle, style: const TextStyle(fontSize: 12))),
      ],
    );
  }
}
