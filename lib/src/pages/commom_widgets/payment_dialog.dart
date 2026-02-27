import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel orddder;
  PaymentDialog({super.key, required this.orddder});

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Stack(
        alignment: Alignment.center,

        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // TITULO
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: const Center(
                    child: Text(
                      'Pagamento com Pix',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),

                // QR CODE
                QrImageView(
                  data: 'lçlks9s9dsd0s0sd',
                  version: QrVersions.auto,
                  size: 200.0,
                ),

                // VENCIMENTO
                Text(
                  'Vencimento: ${utilsServices.formatDateTime(orddder.overdueDateTime)}',
                  style: const TextStyle(fontSize: 12),
                ),

                // TOTAL
                Text(
                  'Total: ${utilsServices.priceToCurrency(orddder.total)}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // BOTÃO COPIA E COLA
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(width: 2, color: Colors.green),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.copy, size: 15, color: Colors.green),
                  label: const Text(
                    'Copiar código Pix',
                    style: TextStyle(fontSize: 13, color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
