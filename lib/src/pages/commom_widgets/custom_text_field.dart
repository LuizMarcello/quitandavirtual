import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData iconn;
  final String labell;
  final bool isSecrett;
  final List<TextInputFormatter>? inputFormattersss;
  final String? initialValuuue;
  final bool readOnlyyy;
  // Função validaaator: Aceita nullable String
  // como parâmetro e retorna nullable String,
  // e ela mesmo também é nullable,
  // não precisa validar todos os campos
  final String? Function(String?)? validaaator;
  // Função onSaveddd: Captura os conteúdos
  // de cada campo do formulário
  // Não retorna nada, e como parâmetro,
  // uma nullable string
  final void Function(String?)? onSaveddd;
  final TextEditingController? controooller;
  // Atributo que ajusta o teclado que vai aparecer,
  // conforme o campo selecionado, exemplo, campo
  // email, já aparece com o arroba
  final TextInputType? textInputTypppe;
  final GlobalKey<FormFieldState>? formFieldKeyyy;

  const CustomTextField(
      {super.key,
      required this.iconn,
      required this.labell,
      this.inputFormattersss,
      this.isSecrett = false,
      this.initialValuuue,
      this.readOnlyyy = false,
      this.validaaator,
      this.onSaveddd,
      this.controooller,
      this.textInputTypppe, 
      this.formFieldKeyyy});
      

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscuree = false;

  @override
  void initState() {
    super.initState();

    // Para que os dois sejam simultâneamente true ou false
    isObscuree = widget.isSecrett;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      ///////////////////////////////////////////////////////////////
      child: TextFormField(
        key: widget.formFieldKeyyy,
        controller: widget.controooller,
        readOnly: widget.readOnlyyy,
        initialValue: widget.initialValuuue,
        inputFormatters: widget.inputFormattersss,
        obscureText: isObscuree,
        validator: widget.validaaator,
        onSaved: widget.onSaveddd,
        // Classe StatefulWidget, necessário
        // acrescentar o widget
        keyboardType: widget.textInputTypppe,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.iconn),

          /// IconButton: Botão e ícone ao mesmo tempo
          suffixIcon: widget.isSecrett
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      // Esta classe passou a ser StatefulWidget
                      // Este "widget" é para acessar esta variável
                      // "isObscuree" lá em cima
                      isObscuree = !isObscuree;
                    });
                  },
                  icon: Icon(
                    isObscuree ? Icons.visibility : Icons.visibility_off,
                  ),
                )
              : null,
          labelText: widget.labell,
          isDense: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
      ),
      ////////////////////////////////////////////////////////////////
    );
  }
}
