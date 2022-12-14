import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/base/controller/navigation_controller.dart';
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:green_grocer/src/pages/common_widgets/quantity_widget.dart';
import 'package:green_grocer/src/services/utils_services.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int cartItemQuantity = 1;
  late ItemModel item;

  @override
  void initState() {
    item = Get.arguments;
    super.initState();
  }

  final navigatonController = Get.find<NavigationController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          // content
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: item.imgUrl,
                  child: Image.network(item.imgUrl),
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(50),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade600,
                          // offset: const Offset(0, 2),
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Name - Quant
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.itemName,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 100,
                              child: QuantityWidget(
                                suffixText: item.unit,
                                value: cartItemQuantity,
                                result: ((int quantity) {
                                  setState(() {
                                    cartItemQuantity = quantity;
                                  });
                                }),
                              ),
                            )
                          ],
                        ),
                        // Price
                        Text(
                          UtilsServices.priceToCurrency(item.price),
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.customSwatchColor),
                        ),
                        // Description
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SingleChildScrollView(
                              child: Text(
                                item.description,
                                style: const TextStyle(height: 1.5),
                              ),
                            ),
                          ),
                        ),
                        //  add button
                        SizedBox(
                          height: 55,
                          child: ElevatedButton.icon(
                            label: const Text(
                              'Add no carrinho',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            icon: const Icon(Icons.shopping_cart_outlined),
                            onPressed: () async {
                              Get.back();
                              await cartController.addItemToCart(
                                item: item,
                                quantity: cartItemQuantity,
                              );
                              navigatonController.navigatePageView(
                                page: NavigationTabs.cart,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
            ],
          ),
          Positioned(
            left: 10,
            top: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.arrow_back_ios),
              ),
            ),
          )
        ],
      ),
    );
  }
}
