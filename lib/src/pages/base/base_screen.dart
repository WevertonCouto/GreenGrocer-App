import 'package:flutter/material.dart';
import 'package:green_grocer/src/pages/cart/cart_tab.dart';
import 'package:green_grocer/src/pages/home/home_tab.dart';
import 'package:green_grocer/src/pages/orders/orders_tab.dart';
import 'package:green_grocer/src/pages/profile/profile_tab.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int currentIndex = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HomeTab(),
          CartTab(),
          OrdersTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
                currentIndex = index;
                //pageController.jumpToPage(currentIndex);
                pageController.animateToPage(currentIndex,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.ease);
              }),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withAlpha(100),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined), label: 'Carrinho'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined), label: 'Pedidos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Perfil'),
          ]),
    );
  }
}
