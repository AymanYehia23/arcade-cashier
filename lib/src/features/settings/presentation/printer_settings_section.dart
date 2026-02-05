import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../localization/generated/app_localizations.dart';
import '../data/printer_repository.dart';

class PrinterSettingsSection extends ConsumerStatefulWidget {
  const PrinterSettingsSection({super.key});

  @override
  ConsumerState<PrinterSettingsSection> createState() =>
      _PrinterSettingsSectionState();
}

class _PrinterSettingsSectionState
    extends ConsumerState<PrinterSettingsSection> {
  Printer? _selectedPrinter;
  List<Printer> _printers = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrinters();
  }

  Future<void> _loadPrinters() async {
    final printers = await Printing.listPrinters();
    final savedPrinterUrl = await ref
        .read(printerRepositoryProvider)
        .loadDefaultPrinter();
    Printer? initialSelection;

    if (savedPrinterUrl != null) {
      initialSelection = printers.firstWhere(
        (p) => p.url == savedPrinterUrl,
        orElse: () => printers.first,
      );
    }

    if (mounted) {
      setState(() {
        _printers = printers;
        _selectedPrinter = initialSelection;
        _isLoading = false;
      });
    }
  }

  Future<void> _savePrinter(Printer? printer) async {
    if (printer != null) {
      await ref.read(printerRepositoryProvider).saveDefaultPrinter(printer.url);
      setState(() {
        _selectedPrinter = printer;
      });
    }
  }

  Future<void> _testPrint() async {
    if (_selectedPrinter == null) return;

    final l10n = AppLocalizations.of(context)!;
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(child: pw.Text(l10n.testPrintMessage));
        },
      ),
    );

    await Printing.directPrintPdf(
      printer: _selectedPrinter!,
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.printerSettings,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Printer>(
                  decoration: InputDecoration(
                    labelText: l10n.selectDefaultPrinter,
                    border: const OutlineInputBorder(),
                  ),
                  initialValue: _selectedPrinter,
                  items: _printers.map((printer) {
                    return DropdownMenuItem(
                      value: printer,
                      child: Text(printer.name),
                    );
                  }).toList(),
                  onChanged: _savePrinter,
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _selectedPrinter == null ? null : _testPrint,
                icon: const Icon(Icons.print),
                label: Text(l10n.testPrint),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
