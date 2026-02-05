import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'printer_repository.g.dart';

class PrinterRepository {
  static const String _defaultPrinterKey = 'default_printer_url';

  Future<void> saveDefaultPrinter(String printerUrl) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultPrinterKey, printerUrl);
  }

  Future<String?> loadDefaultPrinter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_defaultPrinterKey);
  }
}

@riverpod
PrinterRepository printerRepository(Ref ref) {
  return PrinterRepository();
}
