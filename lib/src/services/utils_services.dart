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
}
