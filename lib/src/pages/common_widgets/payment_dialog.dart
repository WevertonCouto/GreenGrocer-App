import 'package:flutter/material.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/services/utils_services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentDialog extends StatelessWidget {
  final OrderModel order;

  const PaymentDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // content
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // title
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Pagamento com PIX',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // qr code
                  QrImage(
                    data: '123123',
                    version: QrVersions.auto,
                    size: 200,
                  ),
                  // due date
                  Text(
                    'Vencimento: ${UtilsServices.formatDateTime(order.overdueDateTime)}',
                    style: const TextStyle(fontSize: 12),
                  ),
                  // total
                  Text(
                    'Total: ${UtilsServices.priceToCurrency(order.total)}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // copy and paste btn
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: const BorderSide(width: 2, color: Colors.green)),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.copy,
                      size: 15,
                    ),
                    label: const Text(
                      'Copiar código PIX',
                      style: TextStyle(fontSize: 13),
                    ),
                  )
                ],
              ),
            ),
            // top close btn
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            )
          ],
        ));
  }
}
