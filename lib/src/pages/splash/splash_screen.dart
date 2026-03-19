import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
// import 'package:greengrocer/src/pages/auth/sign_in_screen.dart';
import 'package:greengrocer/src/pages/commom_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages_routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     builder: (c) {
      //       return const SignInScreen();
      //     },
      //   ),
      // );

      // Usando o Get(GetX)
      // Get.offNamed: Remove a tela atual e navega para outra,
      // a tela atual é destruída, NÃO dá para voltar,
      // equivalente ao Navigator.pushReplacement
      Get.offNamed(PagesRoutes.signInRoute);
    });
  }

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
