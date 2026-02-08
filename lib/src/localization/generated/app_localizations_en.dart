// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Arcade Shop ERP';

  @override
  String get loginTitle => 'Login to Arcade Shop';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get loginButton => 'Login';

  @override
  String get loginError => 'Failed to login. Please check your credentials.';

  @override
  String get emailRequired => 'Please enter your email';

  @override
  String get passwordRequired => 'Please enter your password';

  @override
  String get errorTitle => 'Error';

  @override
  String get ok => 'OK';

  @override
  String get dashboardTitle => 'Dashboard';

  @override
  String get statusAvailable => 'Available';

  @override
  String get statusOccupied => 'Occupied';

  @override
  String get statusMaintenance => 'Maintenance';

  @override
  String get statusHeld => 'Held';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get management => 'Management';

  @override
  String get manageRooms => 'Manage Rooms';

  @override
  String get addRoom => 'Add Room';

  @override
  String get editRoom => 'Edit Room';

  @override
  String get deleteRoom => 'Delete Room';

  @override
  String get roomName => 'Room Name';

  @override
  String get deviceType => 'Device Type';

  @override
  String get hourlyRate => 'Hourly Rate';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancelSession => 'Cancel Session';

  @override
  String get cancelSessionConfirmation =>
      'Are you sure you want to cancel this session? The table will be freed without any charges.';

  @override
  String get confirmDelete => 'Are you sure you want to delete this room?';

  @override
  String get roomSaved => 'Room saved successfully';

  @override
  String get roomDeleted => 'Room deleted successfully';

  @override
  String get singleRate => 'Single Rate';

  @override
  String get multiRate => 'Multi Rate';

  @override
  String get otherRate => 'Other Rate';

  @override
  String get twoPlayers => '2 Players';

  @override
  String get fourPlayers => '4 Players';

  @override
  String get startSession => 'Start Session';

  @override
  String get stopSession => 'Stop Session';

  @override
  String get timeElapsed => 'Time Elapsed';

  @override
  String get singleMatch => 'Single Match';

  @override
  String get multiMatch => 'Multi Match';

  @override
  String get activeSession => 'Active Session';

  @override
  String get openTime => 'Open Time';

  @override
  String get fixedTime => 'Fixed Time';

  @override
  String get extendTime => 'Extend Time';

  @override
  String get timeUp => 'TIME UP!';

  @override
  String get minutes => 'min';

  @override
  String get custom => 'Custom';

  @override
  String get duration => 'Duration';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get logout => 'Logout';

  @override
  String get account => 'Account';

  @override
  String get general => 'General';

  @override
  String get loading => 'Loading...';

  @override
  String get manageInventory => 'Manage Inventory';

  @override
  String get noRoomsFound => 'No rooms found';

  @override
  String get retry => 'Retry';

  @override
  String get connectionError =>
      'Connection validation failed. Please try again.';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get sessionStopped => 'Session stopped';

  @override
  String get noActiveSessionFound => 'No active session found.';

  @override
  String get productName => 'Product Name';

  @override
  String get category => 'Category';

  @override
  String get sellingPrice => 'Selling Price';

  @override
  String get stockQuantity => 'Stock Quantity';

  @override
  String get drinks => 'Drinks';

  @override
  String get snacks => 'Snacks';

  @override
  String get food => 'Food';

  @override
  String get other => 'Other';

  @override
  String get otherSession => 'Other Session';

  @override
  String get lowStock => 'Low Stock';

  @override
  String get addProduct => 'Add Product';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get deleteProduct => 'Delete Product';

  @override
  String get confirmDeleteProduct =>
      'Are you sure you want to delete this product?';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get fieldRequired => 'Required';

  @override
  String get invalidNumber => 'Invalid number';

  @override
  String productPriceStock(double price, int stock) {
    final intl.NumberFormat priceNumberFormat = intl.NumberFormat.currency(
      locale: localeName,
      symbol: 'EGP ',
      decimalDigits: 2,
    );
    final String priceString = priceNumberFormat.format(price);

    String _temp0 = intl.Intl.pluralLogic(
      stock,
      locale: localeName,
      other: '$stock',
      zero: 'Out of Stock',
    );
    return 'Price: $priceString | Stock: $_temp0';
  }

  @override
  String get products => 'Products';

  @override
  String get orders => 'Orders';

  @override
  String get total => 'Total';

  @override
  String get bill => 'Bill';

  @override
  String get timeCost => 'Time Cost';

  @override
  String get search => 'Search';

  @override
  String get inventory => 'Inventory';

  @override
  String get invoices => 'Invoices';

  @override
  String get invoiceHistory => 'Invoice History';

  @override
  String get completeSession => 'Complete Session?';

  @override
  String totalBillAmount(String amount) {
    return 'Total Bill: $amount EGP';
  }

  @override
  String get finishAndPrint => 'Finish & Print';

  @override
  String get thankYouMessage => 'Thank you! Visit again';

  @override
  String get invoiceNumber => 'Invoice #';

  @override
  String get noInvoicesFound => 'No invoices found';

  @override
  String get reprintInvoice => 'Reprint Invoice';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get cash => 'Cash';

  @override
  String timeDuration(String duration) {
    return 'Time ($duration)';
  }

  @override
  String get addItems => 'Add Items';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get paused => 'PAUSED';

  @override
  String get analytics => 'Analytics';

  @override
  String get name => 'Name';

  @override
  String get phone => 'Phone';

  @override
  String get newCustomer => 'New Customer';

  @override
  String get searchCustomer => 'Search Customer (Name or Phone)';

  @override
  String get endShift => 'End Shift';

  @override
  String get quickOrder => 'Quick Order';

  @override
  String get somethingWentWrong => 'Something Went Wrong';

  @override
  String get customer => 'Customer';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get discountLabel => 'Discount (%)';

  @override
  String discountValue(String amount) {
    return 'Discount: - $amount EGP';
  }

  @override
  String get sessionCompleted => 'Session completed - Invoice created';

  @override
  String get unknown => 'Unknown';

  @override
  String get egp => 'EGP';

  @override
  String get egpPerHour => 'EGP/hr';

  @override
  String get reportsTitle => 'Reports & Analytics';

  @override
  String get dataRefreshed => 'Data refreshed';

  @override
  String get period => 'Period';

  @override
  String get tabRevenue => 'Revenue';

  @override
  String get tabFinancials => 'Financials';

  @override
  String get tabProducts => 'Products';

  @override
  String get tabRoomUsage => 'Room Usage';

  @override
  String get endOfShiftReport => 'End of Shift Report';

  @override
  String get cashSales => 'Cash Sales';

  @override
  String get cardSales => 'Card Sales';

  @override
  String get totalTransactions => 'Total Transactions';

  @override
  String get netRevenue => 'Net Revenue';

  @override
  String get discountsGiven => 'Discounts Given';

  @override
  String get printZReport => 'Print Z-Report';

  @override
  String get failedToLoadReport => 'Failed to load shift report';

  @override
  String get close => 'Close';

  @override
  String failedToPrintReport(String error) {
    return 'Failed to print report: $error';
  }

  @override
  String get cancelled => 'CANCELLED';

  @override
  String get invoiceNum => 'Invoice #';

  @override
  String get tableItem => 'Item';

  @override
  String get tableQty => 'Qty';

  @override
  String get tableAmount => 'Amount';

  @override
  String get subtotalLabel => 'Subtotal';

  @override
  String get discountLabelPdf => 'Discount';

  @override
  String get totalLabel => 'TOTAL';

  @override
  String get thankYou => 'Thank you!';

  @override
  String get visitAgain => 'Visit again';

  @override
  String get cashierSignature => 'Cashier Signature';

  @override
  String get zReportTitle => 'Z-REPORT';

  @override
  String get paymentCash => 'CASH';

  @override
  String get paymentCard => 'CARD';

  @override
  String get noRevenueData => 'No revenue data available.';

  @override
  String get grossSales => 'Gross Sales';

  @override
  String get profitabilityBySource => 'Profitability by Source';

  @override
  String get tableSource => 'Source';

  @override
  String get tableSessions => 'Sessions';

  @override
  String get tableHours => 'Hours';

  @override
  String get tableRevenue => 'Revenue';

  @override
  String get avgTicket => 'Avg. Ticket';

  @override
  String get grandTotalRevenue => 'Grand Total Revenue: ';

  @override
  String get noDataPeriod => 'No data available for this period.';

  @override
  String get discountsLabel => 'Discounts';

  @override
  String addMinutes(int minutes, String unit) {
    return '+$minutes $unit';
  }

  @override
  String get subtotalWithColon => 'Subtotal:';

  @override
  String remainingTime(String time) {
    return '$time remaining';
  }

  @override
  String get checkoutAndPrint => 'Checkout & Print';

  @override
  String get checkoutShortcut => 'Checkout (Ctrl+S)';

  @override
  String stopSessionShortcut(String stopSession) {
    return '$stopSession (Ctrl+S)';
  }

  @override
  String get perHour => '/hr';

  @override
  String get rateLabel => 'Rate';

  @override
  String get outOfStockLabel => 'Out of Stock';

  @override
  String stockLeft(int count) {
    return '$count Left';
  }

  @override
  String get deleteProductTitle => 'Delete Product?';

  @override
  String deleteProductMessage(String name) {
    return 'Remove \"$name\" from inventory?';
  }

  @override
  String get deleteButton => 'Delete';

  @override
  String periodHeader(String start, String end) {
    return 'Period: $start - $end';
  }

  @override
  String discountsGivenValue(String amount, String currency) {
    return 'Discounts Given: $amount $currency';
  }

  @override
  String get percentSymbol => '%';

  @override
  String get errorConnection =>
      'Unable to connect to server. Please check your internet connection.';

  @override
  String get errorRequestTimedOut => 'Request timed out. Please try again.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorInvalidData => 'Invalid data received. Please try again.';

  @override
  String get errorGeneric => 'An unexpected error occurred. Please try again.';

  @override
  String get voidInvoiceTitle => 'Void Invoice';

  @override
  String get voidInvoiceConfirm =>
      'Are you sure you want to void this invoice? This will remove it from daily revenue.';

  @override
  String get voidAction => 'Void';

  @override
  String printFailed(String error) {
    return 'Print failed: $error';
  }

  @override
  String get noOrdersYet => 'No orders yet';

  @override
  String get errorLoadingOrders => 'Error loading orders';

  @override
  String unknownProduct(String id) {
    return 'Unknown #$id';
  }

  @override
  String get filterToday => 'Today';

  @override
  String get filterThisMonth => 'This Month';

  @override
  String get filterLast3Months => 'Last 3 Months';

  @override
  String get filterThisYear => 'This Year';

  @override
  String get noRoomUsageData => 'No room usage data available.';

  @override
  String get hoursAbbr => 'hrs';

  @override
  String get noProductData => 'No product data available.';

  @override
  String get qtySold => 'Qty Sold';

  @override
  String get rankSymbol => '#';

  @override
  String get printerSettings => 'Printer Settings';

  @override
  String get selectDefaultPrinter => 'Select Default Printer';

  @override
  String get testPrint => 'Test Print';

  @override
  String get testPrintMessage => 'Test Print from Arcade Cashier';

  @override
  String get playstation4 => 'PlayStation 4';

  @override
  String get playstation5 => 'PlayStation 5';

  @override
  String get walkIn => 'Walk-in';

  @override
  String timeUpAlertTitle(String roomName) {
    return 'Time\'s Up! - $roomName';
  }

  @override
  String get timeUpAlertContent => 'The fixed time for this session has ended.';

  @override
  String get checkout => 'Checkout';

  @override
  String get dismiss => 'Dismiss';

  @override
  String get rooms => 'Rooms';

  @override
  String get room => 'Room';

  @override
  String get tables => 'Tables';

  @override
  String get table => 'Table';

  @override
  String get tableNumber => 'Table Number';

  @override
  String get tableName => 'Table Name';

  @override
  String get manageTables => 'Manage Tables';

  @override
  String get status => 'Status';

  @override
  String get noTablesAvailable => 'No tables available';

  @override
  String get addTablesFromSettings => 'Add tables from the settings menu';

  @override
  String errorLoadingTables(String error) {
    return 'Error loading tables: $error';
  }

  @override
  String get addTable => 'Add Table';

  @override
  String get editTable => 'Edit Table';

  @override
  String get deleteTable => 'Delete Table';

  @override
  String deleteTableConfirmation(String tableName) {
    return 'Are you sure you want to delete $tableName?';
  }

  @override
  String get manageTablesTitle => 'Manage Tables';

  @override
  String get createTableSuccess => 'Table created successfully';

  @override
  String get updateTableSuccess => 'Table updated successfully';

  @override
  String get deleteTableSuccess => 'Table deleted successfully';

  @override
  String get ordersOnly => 'Orders Only';

  @override
  String get noTimerForTables => 'Tables are billed by orders only';
}
