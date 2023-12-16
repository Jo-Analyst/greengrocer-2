import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  static String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "PT-BR");
    return numberFormat.format(price);
  }

  static String formateDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat dateFormat = DateFormat.yMd("PT-BR").add_Hm();
    return dateFormat.format(dateTime);
  }

  static void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14.0,
    );
  }
}
