import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';
import 'package:arcade_cashier/src/common_widgets/responsive_center.dart';
import 'package:arcade_cashier/src/features/products/domain/product.dart';
import 'package:arcade_cashier/src/features/products/presentation/products_controller.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:arcade_cashier/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductFormDialog extends ConsumerStatefulWidget {
  final Product? product;

  const ProductFormDialog({super.key, this.product});

  @override
  ConsumerState<ProductFormDialog> createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends ConsumerState<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _nameArController;
  late final TextEditingController _priceController;
  late final TextEditingController _stockController;
  String _category = 'Drinks';
  String _categoryAr = 'المشروبات';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name);
    _nameArController = TextEditingController(text: widget.product?.nameAr);
    _priceController = TextEditingController(
      text: widget.product?.sellingPrice.toString() ?? '',
    );
    _stockController = TextEditingController(
      text: widget.product?.stockQuantity.toString(),
    );
    _category = widget.product?.category ?? 'Drinks';
    _categoryAr = widget.product?.categoryAr ?? 'المشروبات';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameArController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final nameAr = _nameArController.text.trim();
      final price = double.parse(_priceController.text.trim());
      final stock = int.parse(_stockController.text.trim());

      final controller = ref.read(productFormControllerProvider.notifier);

      if (widget.product != null) {
        await controller.updateProduct(
          widget.product!.copyWith(
            name: name,
            nameAr: nameAr,
            category: _category,
            categoryAr: _categoryAr,
            sellingPrice: price,
            stockQuantity: stock,
          ),
        );
      } else {
        // ID 0 is placeholder, DB generates it.
        await controller.createProduct(
          Product(
            id: 0,
            name: name,
            nameAr: nameAr,
            category: _category,
            categoryAr: _categoryAr,
            sellingPrice: price,
            stockQuantity: stock,
            isActive: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      productFormControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final state = ref.watch(productFormControllerProvider);
    final loc = AppLocalizations.of(context)!;

    // Close dialog on success
    ref.listen(productFormControllerProvider, (_, state) {
      if (!state.isLoading && !state.hasError) {
        context.pop();
      }
    });

    return Dialog(
      child: ResponsiveCenter(
        maxContentWidth: 400,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.product != null ? loc.editProduct : loc.addProduct,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: '${loc.productName} (English)',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? loc.fieldRequired : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameArController,
                  decoration: InputDecoration(
                    labelText: '${loc.productName} (العربية)',
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? loc.fieldRequired : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration: InputDecoration(
                    labelText: loc.category,
                    border: const OutlineInputBorder(),
                  ),
                  items: ['Drinks', 'Snacks', 'Food', 'Other'].map((c) {
                    final label = switch (c) {
                      'Drinks' => loc.drinks,
                      'Snacks' => loc.snacks,
                      'Food' => loc.food,
                      'Other' => loc.other,
                      _ => c,
                    };
                    return DropdownMenuItem(value: c, child: Text(label));
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _category = value;
                        // Automatically set Arabic category translation
                        _categoryAr = switch (value) {
                          'Drinks' => 'المشروبات',
                          'Snacks' => 'سناكس',
                          'Food' => 'الطعام',
                          'Other' => 'أخرى',
                          _ => value,
                        };
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: loc.sellingPrice,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.fieldRequired;
                    }
                    if (double.tryParse(value) == null) {
                      return loc.invalidNumber;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _stockController,
                  decoration: InputDecoration(
                    labelText: loc.stockQuantity,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return loc.fieldRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: state.isLoading ? null : () => context.pop(),
                      child: Text(loc.cancel),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: state.isLoading ? null : _submit,
                      child: state.isLoading
                          ? const LogoLoadingIndicator(size: 24)
                          : Text(loc.save),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
