import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/commom_widgets/payment_dialog.dart';
import 'package:greengrocer/src/pages/orders/components/order_status_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel orderrr;

  OrderTile({super.key, required this.orderrr});

  final UtilsServices utilsServiceees = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          // Se vai começar expandido(aberto) ou não
          initiallyExpanded: orderrr.status == 'pending_payment',

          title: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pedido: ${orderrr.id}',
                style: TextStyle(color: Colors.green),
              ),
              Text(
                utilsServiceees.formatDateTime(orderrr.createdDateTime),
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  // Lista de produtos do pedido
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 150,
                      child: ListView(
                        // Este "toList()" no final, é para que
                        // este ListView() retorne uma lista.
                        children: orderrr.itemsss.map((orderIteeem) {
                          return _OrderItemWidget(
                            utilsServices: utilsServiceees,
                            orderIteeem: orderIteeem,
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Divisão na vertical
                  VerticalDivider(
                    color: Colors.grey.shade300,
                    thickness: 2,
                    width: 8,
                  ),

                  // Lista de status do pedido
                  Expanded(
                    flex: 2,
                    // Este é o componente "order_status_widget"
                    // Ele vai ser usado neste segundo Expanded()
                    child: OrderStatusWidget(
                      // statuuus: orderrr.status,
                      statuuus: orderrr.status,
                      // isOverduuue é um boleano. Vai ser comparado se
                      // overdueDateTime está antes ou depois da hora atual
                      // "DateTime.now", e vai receber true ou false, se
                      // está vencido ou não.
                      isOverduuue: orderrr.overdueDateTime.isBefore(
                        DateTime.now(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Total
            Text.rich(
              TextSpan(
                style: const TextStyle(fontSize: 19),
                children: [
                  TextSpan(
                    text: 'Total ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: utilsServiceees.priceToCurrency(orderrr.total),
                  ),
                ],
              ),
            ),

            // Botão pagamento
            Visibility(
              visible: orderrr.status == 'pending_payment',
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return PaymentDialog(orddder: orderrr);
                    },
                  );
                },
                icon: const Icon(Icons.pix, color: Colors.white), // <=== AQUI
                label: const Text(
                  'Ver QR Code Pix',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.utilsServices,
    required this.orderIteeem,
  });

  final UtilsServices utilsServices;
  final CartItemModel orderIteeem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Text(
            '${orderIteeem.quantity} ${orderIteeem.itttem.unit} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(orderIteeem.itttem.itemName)),
          Text(utilsServices.priceToCurrency(orderIteeem.totalPrice())),
        ],
      ),
    );
  }
}
