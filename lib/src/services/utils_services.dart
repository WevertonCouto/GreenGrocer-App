import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class UtilsServices {
  static Future<void> saveLocalData({
    required String key,
    required String data,
  }) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: key, value: data);
  }

  static Future<String?> getLocalData({
    required String key,
  }) async {
    const storage = FlutterSecureStorage();
    return await storage.read(key: key);
  }

  static Future<void> removeLocalData({
    required String key,
  }) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: key);
  }

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

  static Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;
    return base64.decode(base64String);
  }
}
