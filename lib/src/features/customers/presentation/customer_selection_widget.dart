import 'dart:async';

import 'package:arcade_cashier/src/common_widgets/logo_loading_indicator.dart';

import 'package:arcade_cashier/src/features/customers/data/customers_repository.dart';
import 'package:arcade_cashier/src/features/customers/domain/customer.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerSelectionWidget extends ConsumerStatefulWidget {
  final ValueChanged<Customer?> onCustomerSelected;

  const CustomerSelectionWidget({super.key, required this.onCustomerSelected});

  @override
  ConsumerState<CustomerSelectionWidget> createState() =>
      _CustomerSelectionWidgetState();
}

class _CustomerSelectionWidgetState
    extends ConsumerState<CustomerSelectionWidget> {
  Customer? _selectedCustomer;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Customer> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _performSearch(query);
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });
    try {
      final results = await ref
          .read(customersRepositoryProvider)
          .searchCustomers(query);
      if (mounted) {
        setState(() {
          _searchResults = results;
        });
      }
    } catch (e) {
      // Handle error quietly or show snackbar
      debugPrint('Error searching customers: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  Future<void> _showCreateCustomerDialog() async {
    final loc = AppLocalizations.of(context)!;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('New Customer'), // Localize later if needed
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: loc.name,
                  border: const OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel),
          ),
          FilledButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  final newCustomer = await ref
                      .read(customersRepositoryProvider)
                      .createCustomer(
                        name: nameController.text,
                        phone: phoneController.text,
                      );
                  if (context.mounted) {
                    Navigator.pop(context);
                    _selectCustomer(newCustomer);
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating customer: $e')),
                    );
                  }
                }
              }
            },
            child: Text(loc.save),
          ),
        ],
      ),
    );
  }

  void _selectCustomer(Customer customer) {
    setState(() {
      _selectedCustomer = customer;
      _searchController.clear();
      _searchResults = [];
    });
    widget.onCustomerSelected(customer);
  }

  void _clearSelection() {
    setState(() {
      _selectedCustomer = null;
    });
    widget.onCustomerSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    // State 3: Selected
    if (_selectedCustomer != null) {
      return Card(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: ListTile(
          leading: const Icon(Icons.person),
          title: Text(
            _selectedCustomer!.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: _selectedCustomer!.phone != null
              ? Text(_selectedCustomer!.phone!)
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _clearSelection,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      );
    }

    final loc = AppLocalizations.of(context)!;

    // State 1 & 2: Empty / Searching
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: loc.searchCustomer,
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _isSearching
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: LogoLoadingIndicator(size: 16),
                        )
                      : null,
                  border: const OutlineInputBorder(),
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              onPressed: _showCreateCustomerDialog,
              icon: const Icon(Icons.person_add),
              tooltip: loc.newCustomer,
            ),
          ],
        ),
        if (_searchResults.isNotEmpty)
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final customer = _searchResults[index];
                return ListTile(
                  dense: true,
                  title: Text(customer.name),
                  subtitle: customer.phone != null
                      ? Text(customer.phone!)
                      : null,
                  onTap: () => _selectCustomer(customer),
                );
              },
            ),
          ),
      ],
    );
  }
}
