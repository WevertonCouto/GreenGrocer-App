import 'package:get/get.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/pages/orders/repository/orders_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../result/orders_result.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController({required this.order});

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrderItems(
      orderId: order.id,
      token: authController.userModel.token!,
    );

    setLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        UtilsServices.showToast(message: message, isError: true);
      },
    );
  }
}
