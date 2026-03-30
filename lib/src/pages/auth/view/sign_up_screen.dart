import 'package:flutter/material.dart';
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
                          const CustomTextField(
                            iconn: Icons.email,
                            labell: 'Email',
                            validaaator: emailValidator,
                            // Atributo que ajusta o teclado que vai aparecer,
                            // conforme o campo selecionado, exemplo, campo
                            // email, já aparece com o arroba
                            textInputTypppe: TextInputType.emailAddress,
                          ),
                          const CustomTextField(
                            iconn: Icons.lock,
                            labell: 'Senha',
                            validaaator: passwordValidator,
                            isSecrett: true,
                          ),
                          const CustomTextField(
                            iconn: Icons.person,
                            labell: 'Nome',
                            validaaator: nameValidator,
                          ),
                          CustomTextField(
                            iconn: Icons.phone,
                            labell: 'Celular',
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
                            validaaator: cpfValidator,
                            // Atributo que ajusta o teclado que vai aparecer,
                            // conforme o campo selecionado, exemplo, campo
                            // cpf, só aparece numeros
                            textInputTypppe: TextInputType.number,
                            inputFormattersss: [cpfFormatter],
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Cadastrar usuário',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
