import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:green_grocer/src/config/custom_colors.dart';

import '../../pages_route/app_pages.dart';
import '../common_widgets/app_name_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // app name and category
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // app name
                      const AppNameWidget(
                        greenTitleColor: Colors.white,
                        textSize: 40,
                      ),
                      // category
                      SizedBox(
                        height: 30,
                        child: DefaultTextStyle(
                          style: const TextStyle(fontSize: 25),
                          child: AnimatedTextKit(
                              pause: Duration.zero,
                              repeatForever: true,
                              animatedTexts: [
                                FadeAnimatedText('Frutas'),
                                FadeAnimatedText('Verduras'),
                                FadeAnimatedText('Legumes'),
                                FadeAnimatedText('Carnes'),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
                // Form
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(45))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Email text
                      CustomTextField(
                        controller: _emailController,
                        iconData: Icons.email,
                        label: 'Email',
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return 'Type your email.';
                          }
                          if (!email.isEmail) return 'Invalid email.';
                          return null;
                        },
                      ),
                      //Password text
                      CustomTextField(
                        controller: _passwordController,
                        iconData: Icons.password,
                        label: 'Senha',
                        isSecret: true,
                        validator: (String? password) {
                          if (password == null || password.isEmpty) {
                            return 'Type your password.';
                          }
                          if (password.length < 7) return 'Invalid password.';
                          return null;
                        },
                      ),
                      // Login button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            onPressed: () {
                              String email = _emailController.text;
                              String password = _passwordController.text;

                              if (_formKey.currentState!.validate()) {
                                Get.offNamed(PagesRoutes.baseRoute);
                              }
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                      // forgot password button
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                                color: CustomColors.customContrastColor),
                          ),
                        ),
                      ),
                      // Divider
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text('Ou'),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // new user button
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                side: const BorderSide(
                                    width: 2, color: Colors.green)),
                            onPressed: () {
                              Get.toNamed(PagesRoutes.signUpRoute);
                            },
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(fontSize: 18),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
