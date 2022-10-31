import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsServices {
  // R$ value
  static String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(
      locale: 'pt_BR',
    );
    return numberFormat.format(price);
  }

  static String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();
    DateFormat numberFormat = DateFormat.yMd().add_Hm();
    return numberFormat.format(dateTime);
  }

  static void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: isError ? Colors.red : null,
        textColor: isError ? Colors.white : null,
        timeInSecForIosWeb: 3,
        gravity: ToastGravity.BOTTOM);
  }
}
