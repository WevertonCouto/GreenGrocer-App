import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/cart/controller/cart_controller.dart';
import 'package:green_grocer/src/pages_route/app_pages.dart';

import '../../../../services/utils_services.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;

  const ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey imageGlobalKey = GlobalKey();

  IconData tileIcon = Icons.add_shopping_cart_outlined;
  final cartController = Get.find<CartController>();

  Future<void> switchIcon() async {
    setState(() {
      tileIcon = Icons.check;
    });

    await Future.delayed(const Duration(milliseconds: 1500));

    setState(() {
      tileIcon = Icons.add_shopping_cart_outlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () =>
              {Get.toNamed(PagesRoutes.productRoute, arguments: widget.item)},
          child: Card(
            elevation: 2,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // image
                  Expanded(
                    child: Hero(
                        tag: widget.item.itemName,
                        child: Image.network(
                          widget.item.imgUrl,
                          key: imageGlobalKey,
                        )),
                  ),

                  // name
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // price unit
                  Row(
                    children: [
                      Text(
                        UtilsServices.priceToCurrency(widget.item.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwatchColor),
                      ),
                      Text(
                        '/${widget.item.unit}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.green.shade500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // top button
        Positioned(
          top: 4,
          right: 4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15),
              topRight: Radius.circular(20),
            ),
            child: Material(
              child: InkWell(
                onTap: () async {
                  switchIcon();
                  await cartController.addItemToCart(item: widget.item);
                  widget.cartAnimationMethod(imageGlobalKey);
                },
                child: Ink(
                  decoration:
                      BoxDecoration(color: CustomColors.customSwatchColor),
                  height: 40,
                  width: 35,
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
