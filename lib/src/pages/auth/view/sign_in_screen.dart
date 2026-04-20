import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/auth/view/components/forgot_password_dialog.dart';
import 'package:greengrocer/src/pages/commom_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';
import 'package:greengrocer/src/services/utils_services.dart';
import 'package:greengrocer/src/services/validators.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

// Criando um controlador para o widget Form() da linha 80
  final _formKey = GlobalKey<FormState>();

  // Controllers para os campos "email" e "senha"
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    /// Descobrindo o tamanho exato da tela
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
                    /// Nome do app
                    const AppNameWidget(
                      greenTitleColor: Colors.white,
                      textSize: 40,
                    ),

                    /// Categorias
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 25),
                        child: AnimatedTextKit(
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereais'),
                            FadeAnimatedText('Laticinios'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text.rich(
                      const TextSpan(
                        text: "By Luiz Marcello",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Formulário
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 40,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      /// Email
                      CustomTextField(
                        controooller: emailController,
                        iconn: Icons.email,
                        labell: 'Email',
                        validaaator: emailValidator,
                      ),

                      /// Senha
                      CustomTextField(
                        controooller: passwordController,
                        iconn: Icons.lock,
                        labell: 'Senha',
                        isSecrett: true,
                        validaaator: passwordValidator,
                      ),

                      /// Botão de entrar
                      SizedBox(
                          height: 50,
                          child: GetX<AuthController>(
                            // init: AuthController(),
                            // initState: (_) {},
                            // Este "authController" é do tipo "AuthController",
                            // que é uma classe controladora do GetX
                            builder: (authController) {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.green, // seta a cor verde
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                onPressed:
                                    // Passando nulo para um "onPressed" de um
                                    // elevatedButton faz com que ele fique desativado
                                    authController.isLoooading.value
                                        ? null
                                        : () {
                                            // Para fechar o teclado após digitar
                                            // Tira o foco de todos os campos de texto
                                            FocusScope.of(context).unfocus();

                                            /// pushReplacement()
                                            /// Tira a tela atual da pilha, e troca por esta
                                            // Navigator.of(context).pushReplacement(
                                            //   MaterialPageRoute(
                                            //     builder: (context) {
                                            //       return const BaseScreen();
                                            //     },
                                            //   ),
                                            // );

                                            // Usando o Get(GetX) para fazer a mesma coisa
                                            // Get.offNamed: Remove a tela atual e navega para outra,
                                            // a tela atual é destruída, NÃO dá para voltar,
                                            // equivalente ao Navigator.pushReplacement
                                            /// Get.offNamed(PagesRoutes.baseRoute);

                                            // O currentState é nullable, com este
                                            // "!" no final, ele não é mais nullable
                                            // Esta condicional retorna true se todos
                                            // os campos digitados no formulário
                                            // estiverem válidos.
                                            if (_formKey.currentState!
                                                .validate()) {
                                              String emaiiil =
                                                  emailController.text;
                                              String passwooord =
                                                  passwordController.text;

                                              authController.signIn(
                                                  email: emaiiil,
                                                  password: passwooord);
                                            }
                                          },
                                // Fazendo uma verificação ternária
                                // Variável observável "isLoooading"
                                child: authController.isLoooading.value
                                    ? CircularProgressIndicator()
                                    : const Text(
                                        'Entrar',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                              );
                            },
                          )),

                      /// Botão Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async {
                            // Aqui, está recebendo o bool "true" do ElevatesButton
                            // "Recuperar" da classe forgot_password_dialog.dart, do
                            // código "Get.back(result: true)", porque esta tela,
                            // é a tela anterior daquela
                            final bool? resssult = await showDialog(
                                context: context,
                                builder: (_) {
                                  return ForgotPasswordDialog(
                                      email: emailController.text);
                                });
                            // Se clicar no X para fechar, ou fora da janela,
                            // é nulo, não entra no "if"
                            // Se clicar em "recuperar", não é nulo, entra no "if"
                            // ??: Se o valor da esquerda for null, use o da direita
                            if (resssult ?? false) {
                              utilsServices.showToast(
                                  messssage:
                                      'Um link de recuperação foi enviado para o seu email!');
                            }
                          },
                          child: Text(
                            'Esqueceu a senha?',
                            style: TextStyle(
                              color: CustomColors.customContrastColor,
                            ),
                          ),
                        ),
                      ),

                      /// Divisor
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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

                      /// Botão criar conta. Somente bordas
                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            side:
                                const BorderSide(width: 2, color: Colors.green),
                          ),
                          onPressed: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       return SignUpScreen();
                            //     },
                            //   ),
                            // );

                            // Usando o Get(GetX) para fazer a mesma coisa
                            // Get.toNamed: Empilha uma nova página,
                            // mantém a tela atual na pilha,
                            // permite voltar com Get.back(),
                            // Equivalente ao Navigator.push
                            Get.toNamed(PagesRoutes.signUpRoute);
                          },
                          child: Text(
                            'Criar conta',
                            style: TextStyle(fontSize: 18, color: Colors.green),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
