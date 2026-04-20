import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

// O "crud" para fazer o salvamento, recuperação e deleção
// Método para salvar o dado localmente, em segurança
  Future<void> saveLocalData(
      {required String keyyy, required String dattta}) async {
    await storage.write(key: keyyy, value: dattta);
  }

// Método para recuperar o dado salvo localmente, em segurança
  Future<String?> getLocalData({required String kkkey}) async {
    return await storage.read(key: kkkey);
  }

// Método para remover o dado salvo localmente
  Future<void> removeLocalData({required String keeey}) async {
    await storage.delete(key: keeey);
  }

  // R$ valor
  // currency=moeda
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  //

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_BR').add_Hm();
    return dateFormat.format(dateTime);
  }

// Usando o pacote fluttertoast: forma de mostrar uma mensagem
// rápida na tela, tipo um aviso pequeno que aparece por alguns
// segundos e depois some sozinho.
  void showToast({required String messssage, bool isErrooor = false}) {
    Fluttertoast.showToast(
      msg: messssage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isErrooor ? Colors.red : Colors.white,
      textColor: isErrooor ? Colors.white : Colors.black,
      fontSize: 14.0,
    );
  }
}
