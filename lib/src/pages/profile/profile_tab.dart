import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/services/validators.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final authController = Get.find<AuthController>();

  Future<bool?> updateProfile() {
    final passwordController = TextEditingController();
    final globalkey = GlobalKey<FormState>();

    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: globalkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          "Atualização de senha",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Senha
                      const CustomTextField(
                        isSecret: true,
                        icon: Icons.lock,
                        label: "Senha atual",
                        validator: passwordValidator,
                      ),
                      // Nova Senha
                      CustomTextField(
                        controller: passwordController,
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: "Nova Senha",
                        validator: passwordValidator,
                      ),
                      // Confirmação da senha
                      CustomTextField(
                        isSecret: true,
                        icon: Icons.lock_outline,
                        label: "Confirmar nova senha",
                        validator: (password) {
                          final result = passwordValidator(password);

                          if (result != null) return result;

                          if (password != passwordController.text) {
                            return "As senhas não se equivalem";
                          }

                          return null;
                        },
                      ),
                      // Botão de confirmação
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (globalkey.currentState!.validate()) {}
                          },
                          child: const Text("Atualizar"),
                        ),
                      ),
                    ],
                  ),
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {
              authController.signinOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        physics: const BouncingScrollPhysics(),
        children: [
          // Email
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.email,
            icon: Icons.email,
            label: "Email",
          ),

          // Nome
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.name,
            icon: Icons.person,
            label: "Nome",
          ),
          // Celular
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.phone,
            icon: Icons.phone,
            label: "Celular",
          ),
          // CPF
          CustomTextField(
            readOnly: true,
            initialValue: authController.user.cpf,
            isSecret: true,
            icon: Icons.file_copy,
            label: "CPF",
          ),

          // Botão para atualizar
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updateProfile();
              },
              child: const Text("Atualizar Senha"),
            ),
          ),
        ],
      ),
    );
  }
}
