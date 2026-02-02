import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toSmartString() {
    final formatter = NumberFormat("#,##0.##", "en_US");
    return formatter.format(this);
  }
}
