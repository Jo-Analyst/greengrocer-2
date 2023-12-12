import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/pages/auth/sign_up_screen.dart';
import 'package:greengrocer/src/pages/base/base_screen.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppNameWidget(
                      textSize: 40,
                      greenTitleColor: Colors.white,
                    ),

                    // categoria
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          repeatForever: true,
                          animatedTexts: [
                            FadeAnimatedText("Frutas"),
                            FadeAnimatedText("Legumes"),
                            FadeAnimatedText("Carnes"),
                            FadeAnimatedText("Cereais"),
                            FadeAnimatedText("Laticineos"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

              // Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(45),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Email
                    const CustomTextField(
                      icon: Icons.email,
                      label: "Email",
                    ),

                    // Senha
                    const CustomTextField(
                      icon: Icons.lock,
                      label: "Senha",
                      isSecret: true,
                    ),

                    // Botão Entrar
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => const BaseScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),

                    // Botão esqueceu a senha
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Esqueceu a Senha?",
                          style: TextStyle(
                              color: CustomColors.customContrastColor),
                        ),
                      ),
                    ),
                    // Divisores
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
                            child: Text("OU"),
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

                    // Botão criar conta
                    SizedBox(
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          side: const BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 12, 195, 18),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpScreen())),
                        child: const Text(
                          "Criar conta",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
