/// Helper model for PDF generation.
/// This is not persisted to the database - used only for building
/// the invoice PDF items list.
class InvoiceItem {
  final String name;
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  const InvoiceItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
  });

  /// Creates an InvoiceItem for time duration cost
  factory InvoiceItem.timeDuration({
    required String durationFormatted,
    required double totalCost,
  }) {
    return InvoiceItem(
      name: 'Time ($durationFormatted)',
      quantity: 1,
      unitPrice: totalCost,
      totalPrice: totalCost,
    );
  }
}
