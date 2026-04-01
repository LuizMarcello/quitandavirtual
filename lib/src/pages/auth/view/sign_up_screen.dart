import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final cpfFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final phoneFormatter = MaskTextInputFormatter(
    mask: '## # ####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

// A key para o widget Form(), da linha 58
  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    // Descobrindo o tamanho exato da tela
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Cadastro',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 35),
                      ),
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
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(45),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            iconn: Icons.email,
                            labell: 'Email',
                            // Valor informado no campo email
                            onSaveddd: (value) {
                              authController.uuuser.email = value;
                            },
                            validaaator: emailValidator,
                            // Atributo que ajusta o teclado que vai aparecer,
                            // conforme o campo selecionado, exemplo, campo
                            // email, já aparece com o arroba
                            textInputTypppe: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            iconn: Icons.lock,
                            labell: 'Senha',
                            // Valor informado no campo senha
                            onSaveddd: (value) {
                              authController.uuuser.password = value;
                            },
                            validaaator: passwordValidator,
                            isSecrett: true,
                          ),
                          CustomTextField(
                            iconn: Icons.person,
                            labell: 'Nome',
                            // Valor informado no campo nome
                            onSaveddd: (value) {
                              authController.uuuser.name = value;
                            },
                            validaaator: nameValidator,
                          ),
                          CustomTextField(
                            iconn: Icons.phone,
                            labell: 'Celular',
                            // Valor informado no campo celular
                            onSaveddd: (value) {
                              authController.uuuser.phone = value;
                            },

                            validaaator: phoneValidator,
                            // Atributo que ajusta o teclado que vai aparecer,
                            // conforme o campo selecionado, exemplo, campo
                            // phone, só aparece numeros
                            textInputTypppe: TextInputType.phone,
                            inputFormattersss: [phoneFormatter],
                          ),
                          CustomTextField(
                            iconn: Icons.file_copy,
                            labell: 'CPF',
                            // Valor informado no campo cpf
                            onSaveddd: (value) {
                              authController.uuuser.cpf = value;
                            },
                            validaaator: cpfValidator,
                            // Atributo que ajusta o teclado que vai aparecer,
                            // conforme o campo selecionado, exemplo, campo
                            // cpf, só aparece numeros
                            textInputTypppe: TextInputType.number,
                            inputFormattersss: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: authController.isLoooading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();

                                          if (
                                              // Executa a validação de todos os campos do formulário
                                              // Se todos forem válidos → retorna true
                                              // Se algum for inválido → retorna false
                                              // chama todos os validaaator() de todos os campos
                                              _formKey.currentState!
                                                  .validate()) {
                                            // Se esa validação acorrer com sucesso:
                                            // Aciona o onSaved() de cada um dos campos
                                            // e seta a variável referente, do "uuuser"
                                            // da classe authController:
                                            _formKey.currentState!.save();
                                            authController.signUp();
                                          }
                                        },
                                  child: authController.isLoooading.value
                                      ? CircularProgressIndicator()
                                      : const Text(
                                          'Cadastrar usuário',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                left: 10,
                child: SafeArea(
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
