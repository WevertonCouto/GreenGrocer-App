import 'package:flutter/material.dart';
import 'package:green_grocer/src/config/custom_colors.dart';
import 'package:green_grocer/src/models/item_model.dart';
import 'package:green_grocer/src/pages/product/product_screen.dart';

import '../../../services/utils_services.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final void Function(GlobalKey) cartAnimationMethod;
  final GlobalKey imageGlobalKey = GlobalKey();

  ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductScreen(
                      item: item,
                    )))
          },
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
                        tag: item.itemName,
                        child: Image.asset(
                          item.imgUrl,
                          key: imageGlobalKey,
                        )),
                  ),

                  // name
                  Text(
                    item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // price unit
                  Row(
                    children: [
                      Text(
                        UtilsServices.priceToCurrency(item.price),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: CustomColors.customSwatchColor),
                      ),
                      Text(
                        '/${item.unit}',
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
          child: GestureDetector(
            onTap: () {
              cartAnimationMethod(imageGlobalKey);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.customSwatchColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(20),
                  )),
              height: 40,
              width: 35,
              child: const Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        )
      ],
    );
  }
}
