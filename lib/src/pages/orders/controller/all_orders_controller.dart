import 'package:get/get.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/auth/controller/auth_controller.dart';
import 'package:green_grocer/src/pages/orders/repository/orders_repository.dart';
import 'package:green_grocer/src/pages/orders/result/orders_result.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrders(
      userId: authController.userModel.id!,
      token: authController.userModel.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders
          ..sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
        update();
      },
      error: (message) {
        UtilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
