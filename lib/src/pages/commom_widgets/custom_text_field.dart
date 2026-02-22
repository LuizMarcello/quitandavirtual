import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData iconn;
  final String labell;
  final bool isSecrett;
  final List<TextInputFormatter>? inputFormattersss;
  final String? initialValuuue;
  final bool readOnlyyy;

  const CustomTextField({
    super.key,
    required this.iconn,
    required this.labell,
    this.inputFormattersss,
    this.isSecrett = false,
    this.initialValuuue,
    this.readOnlyyy = false,
  });

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
        readOnly: widget.readOnlyyy,
        initialValue: widget.initialValuuue,

        inputFormatters: widget.inputFormattersss,
        obscureText: isObscuree,
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
