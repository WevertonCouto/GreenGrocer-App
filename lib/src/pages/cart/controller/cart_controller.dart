import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/models/order_model.dart';
import 'package:green_grocer/src/pages/cart/repository/cart_repository.dart';
import 'package:green_grocer/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/item_model.dart';
import '../../auth/controller/auth_controller.dart';
import '../../common_widgets/payment_dialog.dart';
import '../result/cart_result.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  List<CartItemModel> cartItems = [];
  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;
    for (final item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.userModel.token!,
      userId: authController.userModel.id!,
    );

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (message) {
      UtilsServices.showToast(message: message, isError: true);
    });
  }

  int getItemIndex(ItemModel item) =>
      cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);

  Future<void> addItemToCart({
    required ItemModel item,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final product = cartItems[itemIndex];
      await changeItemQuantity(
          item: product, quantity: product.quantity + quantity);
    } else {
      final CartResult<String> result = await cartRepository.addItemToCart(
        userId: authController.userModel.id!,
        token: authController.userModel.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(success: (cartItemId) {
        cartItems.add(
          CartItemModel(
            id: cartItemId,
            item: item,
            quantity: quantity,
          ),
        );
      }, error: ((message) {
        UtilsServices.showToast(
          message: message,
        );
      }));
    }

    update();
  }

  Future<bool> changeItemQuantity(
      {required CartItemModel item, required int quantity}) async {
    final result = await cartRepository.changeItemQuantity(
      token: authController.userModel.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere(
          (cartItem) => cartItem.id == item.id,
        );
      } else {
        cartItems
            .firstWhere(
              (cartItem) => cartItem.id == item.id,
            )
            .quantity = quantity;
      }

      update();
    } else {
      UtilsServices.showToast(
        message: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);

    final CartResult<OrderModel> result = await cartRepository.checkoutCart(
        token: authController.userModel.token!, total: cartTotalPrice());

    result.when(success: (order) {
      cartItems.clear();
      setCheckoutLoading(false);
      showDialog(
        context: Get.context!,
        builder: (_) => PaymentDialog(order: order),
      );
    }, error: (message) {
      UtilsServices.showToast(
        message: message,
      );
    });
  }
}
