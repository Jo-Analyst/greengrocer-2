import 'package:flutter/material.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;
  const PaymentDialog({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Pagamento por pix",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // QR Code
                QrImageView(
                  data: "Joelmir Rogério Carvalho",
                  version: QrVersions.auto,
                  size: 200,
                ),

                // Vencimento
                Text(
                  "Vencimento: ${UtilsServices.formateDateTime(order.overdueDateTime)}",
                  style: const TextStyle(fontSize: 12),
                ),

                // Total
                Text(
                  "Total: ${UtilsServices.priceToCurrency(order.total)}",
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Botão Copia e Cola
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: const BorderSide(color: Colors.green, width: 2),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.copy,
                    size: 15,
                  ),
                  label: const Text(
                    "Copiar código Pix",
                    style: TextStyle(fontSize: 13),
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
