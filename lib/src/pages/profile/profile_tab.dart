import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Future<bool?> updateProfile() {
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
                    ),
                    // Nova Senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: "Nova Senha",
                    ),
                    // Confirmação da senha
                    const CustomTextField(
                      isSecret: true,
                      icon: Icons.lock_outline,
                      label: "Confirmar nova senha",
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
                        onPressed: () {},
                        child: const Text("Atualizar"),
                      ),
                    ),
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
            onPressed: () {},
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
            initialValue: app_data.user.email,
            icon: Icons.email,
            label: "Email",
          ),

          // Nome
          CustomTextField(
            readOnly: true,
            initialValue: app_data.user.name,
            icon: Icons.person,
            label: "Nome",
          ),
          // Celular
          CustomTextField(
            readOnly: true,
            initialValue: app_data.user.phone,
            icon: Icons.phone,
            label: "Celular",
          ),
          // CPF
          CustomTextField(
            readOnly: true,
            initialValue: app_data.user.cpf,
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
