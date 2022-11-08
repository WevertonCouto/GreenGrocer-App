import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/splash/splash_screen.dart';
import 'package:green_grocer/src/pages_route/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Greengrocer',
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white.withAlpha(190)),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      getPages: AppPages.pages,
      initialRoute: PagesRoutes.splashRoute,
    );
  }
}
