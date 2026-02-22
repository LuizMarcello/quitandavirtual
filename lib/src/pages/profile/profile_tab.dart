// ignore_for_file: library_prefixes

import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as appDart;
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/commom_widgets/custom_text_field.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil do Usuário',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          // Email
          CustomTextField(
            readOnlyyy: true,
            initialValuuue: appDart.user.email,
            iconn: Icons.email,
            labell: 'Email',
          ),

          // Nome
          CustomTextField(
            readOnlyyy: true,
            initialValuuue: appDart.user.name,
            iconn: Icons.person,
            labell: 'Nome',
          ),

          // Celular
          CustomTextField(
            readOnlyyy: true,
            initialValuuue: appDart.user.phone,
            iconn: Icons.phone,
            labell: 'Celular',
          ),

          // Cpf
          CustomTextField(
            readOnlyyy: true,
            initialValuuue: appDart.user.cpf,
            iconn: Icons.file_copy,
            labell: 'CPF',
            isSecrett: true,
          ),

          // Botão para atualizar a senha
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: Text(
                'Atualizar Senha',
                style: TextStyle(color: CustomColors.customSwatchColor),
              ),
            ),
          ),
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
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'Atualização da senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const CustomTextField(
                      isSecrett: true,
                      iconn: Icons.lock,
                      labell: 'Senha atual',
                    ),
                    const CustomTextField(
                      isSecrett: true,
                      iconn: Icons.lock_outline,
                      labell: 'Nova senha',
                    ),
                    const CustomTextField(
                      isSecrett: true,
                      iconn: Icons.lock_outline,
                      labell: 'Confirmar nova senha',
                    ),

                    // Botão de confirmação
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.customSwatchColor,
                          // backgroundColor: CustomColors.customSwatchColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Atualizar',
                          style: TextStyle(color: Colors.white),
                        ),
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
}
