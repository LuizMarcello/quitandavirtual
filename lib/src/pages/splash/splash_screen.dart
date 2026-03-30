import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
// import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/commom_widgets/app_name_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Esta classe splashScreen não tem mais a navegação
  // para a tela SignInScreen. Ela agora só vai apresentar
  // o splash mesmo. A navegação agora ficou por conta da 
  // classe AurthController, método Future validateToken

  // @override
  // void initState() {
  //   super.initState();

  //   Future.delayed(const Duration(seconds: 5), () {
  //     // ignore: use_build_context_synchronously
  //     // Navigator.of(context).pushReplacement(
  //     //   MaterialPageRoute(
  //     //     builder: (c) {
  //     //       return const SignInScreen();
  //     //     },
  //     //   ),
  //     // );

  //     // Usando o Get(GetX)
  //     // Get.offNamed: Remove a tela atual e navega para outra,
  //     // a tela atual é destruída, NÃO dá para voltar,
  //     // equivalente ao Navigator.pushReplacement
  //     Get.offNamed(PagesRoutes.signInRoute);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.customSwatchColor,
              CustomColors.customSwatchColor.shade700,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AppNameWidget(greenTitleColor: Colors.white, textSize: 40),
            SizedBox(height: 15),
            Text.rich(
              const TextSpan(
                text: "By Luiz Marcello",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
