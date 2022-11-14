import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:green_grocer/src/config/app_data.dart';
import 'package:green_grocer/src/pages/common_widgets/custom_text_field.dart';

import '../auth/controller/auth_controller.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil do usuário'),
        actions: [
          IconButton(
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // email
          CustomTextField(
            iconData: Icons.email,
            label: 'Email',
            initialText: authController.userModel.email,
            readOnly: true,
          ),

          // name
          CustomTextField(
            iconData: Icons.person,
            label: 'Nome',
            initialText: authController.userModel.name,
            readOnly: true,
          ),

          // phone
          CustomTextField(
            iconData: Icons.phone,
            label: 'Celular',
            initialText: authController.userModel.phone,
            readOnly: true,
          ),

          // cpf
          CustomTextField(
            iconData: Icons.file_copy,
            label: 'CPF',
            isSecret: true,
            initialText: authController.userModel.cpf,
            readOnly: true,
          ),

          // btn update password
          SizedBox(
            height: 50,
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    side: const BorderSide(color: Colors.green)),
                onPressed: () async {
                  await updatePassword();
                },
                child: const Text('Atualizar senha')),
          )
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //title
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização de senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // password
                    const CustomTextField(
                      iconData: Icons.lock,
                      label: 'Senha atual',
                      isSecret: true,
                    ),
                    // new password
                    const CustomTextField(
                      iconData: Icons.lock_outline,
                      label: 'Nova senha',
                      isSecret: true,
                    ),
                    // confirm new password
                    const CustomTextField(
                      iconData: Icons.lock_outline,
                      label: 'Confirmar nova senha',
                      isSecret: true,
                    ),
                    // confirm password btn
                    SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {},
                            child: const Text('Atualizar')))
                  ],
                ),
              ),
              Positioned(
                  top: 5,
                  right: 5,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ))
            ],
          ),
        );
      },
    );
  }
}
