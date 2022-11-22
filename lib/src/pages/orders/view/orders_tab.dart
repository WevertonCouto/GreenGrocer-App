import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/orders/components/order_tile.dart';
import 'package:green_grocer/src/pages/orders/controller/all_orders_controller.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (_, index) => const SizedBox(
                    height: 10,
                  ),
              itemBuilder: (context, index) {
                return OrderTile(
                  order: controller.allOrders[index],
                );
              },
              itemCount: controller.allOrders.length);
        },
      ),
    );
  }
}
