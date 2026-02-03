// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'إدارة متجر الألعاب';

  @override
  String get brandName => 'أركيد';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'دخول';

  @override
  String get loginError => 'فشل تسجيل الدخول. يرجى التحقق من البيانات.';

  @override
  String get emailRequired => 'يرجى إدخال البريد الإلكتروني';

  @override
  String get passwordRequired => 'يرجى إدخال كلمة المرور';

  @override
  String get errorTitle => 'خطأ';

  @override
  String get ok => 'موافق';

  @override
  String get dashboardTitle => 'لوحة التحكم';

  @override
  String get statusAvailable => 'متاح';

  @override
  String get statusOccupied => 'مشغول';

  @override
  String get statusMaintenance => 'صيانة';

  @override
  String get statusHeld => 'محجوز';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get manageRooms => 'إدارة الغرف';

  @override
  String get addRoom => 'إضافة غرفة';

  @override
  String get editRoom => 'تعديل الغرفة';

  @override
  String get deleteRoom => 'حذف الغرفة';

  @override
  String get roomName => 'اسم الغرفة';

  @override
  String get deviceType => 'نوع الجهاز';

  @override
  String get hourlyRate => 'السعر بالساعة';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirmDelete => 'هل أنت متأكد أنك تريد حذف هذه الغرفة؟';

  @override
  String get roomSaved => 'تم حفظ الغرفة بنجاح';

  @override
  String get roomDeleted => 'تم حذف الغرفة بنجاح';

  @override
  String get singleRate => 'سعر الفردي';

  @override
  String get multiRate => 'سعر الزوجي';

  @override
  String get twoPlayers => '2 لاعبين';

  @override
  String get fourPlayers => '4 لاعبين';

  @override
  String get startSession => 'بدء الجلسة';

  @override
  String get stopSession => 'إنهاء الجلسة';

  @override
  String get timeElapsed => 'الوقت المنقضي';

  @override
  String get singleMatch => 'لعب فردي';

  @override
  String get multiMatch => 'لعب زوجي';

  @override
  String get activeSession => 'جلسة نشطة';

  @override
  String get openTime => 'وقت مفتوح';

  @override
  String get fixedTime => 'وقت محدد';

  @override
  String get extendTime => 'تمديد الوقت';

  @override
  String get timeUp => 'انتهى الوقت!';

  @override
  String get minutes => 'دقيقة';

  @override
  String get custom => 'مخصص';

  @override
  String get duration => 'المدة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get account => 'الحساب';

  @override
  String get general => 'عام';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get manageInventory => 'إدارة المخزون';

  @override
  String get noRoomsFound => 'لا توجد غرف';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get connectionError =>
      'فشل التحقق من الاتصال. يرجى المحاولة مرة أخرى.';

  @override
  String errorMessage(String error) {
    return 'خطأ: $error';
  }

  @override
  String get sessionStopped => 'تم إيقاف الجلسة';

  @override
  String get noActiveSessionFound => 'لا توجد جلسة نشطة.';

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
  String get endShift => 'إنهاء الوردية';

  @override
  String get quickOrder => 'طلب سريع';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get customer => 'العميل';

  @override
  String get paymentDetails => 'تفاصيل الدفع';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get discountLabel => 'خصم (%)';

  @override
  String discountValue(String amount) {
    return 'خصم: - $amount ج.م';
  }

  @override
  String get sessionCompleted => 'تم إنهاء الجلسة - تم إنشاء الفاتورة';

  @override
  String get unknown => 'غير معروف';

  @override
  String get egp => 'ج.م';

  @override
  String get egpPerHour => 'ج.م/ساعة';

  @override
  String get reportsTitle => 'التقارير والتحليلات';

  @override
  String get period => 'الفترة';

  @override
  String get tabRevenue => 'الإيرادات';

  @override
  String get tabFinancials => 'المالية';

  @override
  String get tabProducts => 'المنتجات';

  @override
  String get tabRoomUsage => 'استخدام الغرف';

  @override
  String get endOfShiftReport => 'تقرير نهاية الوردية';

  @override
  String get cashSales => 'مبيعات نقدية';

  @override
  String get cardSales => 'مبيعات بطاقة';

  @override
  String get totalTransactions => 'إجمالي المعاملات';

  @override
  String get netRevenue => 'صافي الإيرادات';

  @override
  String get discountsGiven => 'الخصومات المقدمة';

  @override
  String get printZReport => 'طباعة تقرير Z';

  @override
  String get failedToLoadReport => 'فشل تحميل التقرير';

  @override
  String get close => 'إغلاق';

  @override
  String failedToPrintReport(String error) {
    return 'فشل طباعة التقرير: $error';
  }

  @override
  String get cancelled => 'ملغاة';

  @override
  String get invoiceNum => 'رقم الفاتورة';

  @override
  String get tableItem => 'الصنف';

  @override
  String get tableQty => 'الكمية';

  @override
  String get tableAmount => 'المبلغ';

  @override
  String get subtotalLabel => 'المجموع الفرعي';

  @override
  String get discountLabelPdf => 'الخصم';

  @override
  String get totalLabel => 'الإجمالي';

  @override
  String get thankYou => 'شكراً لك!';

  @override
  String get visitAgain => 'شرفتنا';

  @override
  String get cashierSignature => 'توقيع الكاشير';

  @override
  String get zReportTitle => 'تقرير وردية';

  @override
  String get paymentCash => 'نقدي';

  @override
  String get paymentCard => 'بطاقة';

  @override
  String get noRevenueData => 'لا توجد بيانات للإيرادات.';

  @override
  String get grossSales => 'إجمالي المبيعات';

  @override
  String get profitabilityBySource => 'الربحية حسب المصدر';

  @override
  String get tableSource => 'المصدر';

  @override
  String get tableSessions => 'الجلسات';

  @override
  String get tableHours => 'الساعات';

  @override
  String get tableRevenue => 'الإيرادات';

  @override
  String get avgTicket => 'متوسط التذكرة';

  @override
  String get grandTotalRevenue => 'إجمالي الإيرادات الكلي: ';

  @override
  String get noDataPeriod => 'لا توجد بيانات لهذه الفترة.';

  @override
  String get discountsLabel => 'الخصومات';
}
