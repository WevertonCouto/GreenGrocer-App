import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/models/cart_item_model.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/common_widgets/payment_dialog.dart';
import 'package:green_grocer/src/pages/orders/controller/oder_controller.dart';
import 'package:green_grocer/src/services/utils_services.dart';

import 'order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order: order),
            global: false,
            builder: (controller) {
              return ExpansionTile(
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                initiallyExpanded: order.status == 'pending_payment',
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      UtilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        )
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              // product list
                              Expanded(
                                  flex: 3,
                                  child: SizedBox(
                                    height: 150,
                                    child: ListView(
                                      children:
                                          order.items.map<Widget>((orderItem) {
                                        return SizedBox(
                                          height: 25,
                                          child: _OrderItemWidget(
                                            orderItem: orderItem,
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )),
                              //divider
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                                width: 8,
                              ),
                              // order status
                              Expanded(
                                  flex: 2,
                                  child: OrderStatusWidget(
                                    status: order.status,
                                    isOverdue: order.overdueDateTime
                                        .isBefore(DateTime.now()),
                                  )),
                            ],
                          ),
                        ),
                        // total
                        Text.rich(
                          TextSpan(
                            style: const TextStyle(fontSize: 20),
                            children: [
                              const TextSpan(
                                text: 'Total ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    UtilsServices.priceToCurrency(order.total),
                              ),
                            ],
                          ),
                        ),
                        // payment btn
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (_) => PaymentDialog(order: order),
                              );
                            },
                            icon: Image.asset(
                              'assets/app_images/pix.png',
                              height: 18,
                            ),
                            label: const Text('Ver QR Code PIX'),
                          ),
                        ),
                      ],
              );
            },
          )),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  final CartItemModel orderItem;

  const _OrderItemWidget({Key? key, required this.orderItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(UtilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
