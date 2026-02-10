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
  String get management => 'الإدارة';

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
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get cancelSession => 'إلغاء الجلسة';

  @override
  String get cancelSessionConfirmation =>
      'هل أنت متأكد من إلغاء هذه الجلسة؟ سيتم تحرير الطاولة بدون أي رسوم.';

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
  String get otherRate => 'سعر الجلسات الآخرى';

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
  String get productName => 'اسم المنتج';

  @override
  String get category => 'الفئة';

  @override
  String get sellingPrice => 'سعر البيع';

  @override
  String get stockQuantity => 'كمية المخزون';

  @override
  String get drinks => 'مشروبات';

  @override
  String get snacks => 'سناكس';

  @override
  String get food => 'مأكولات';

  @override
  String get other => 'أخرى';

  @override
  String get otherSession => 'جلسة أخرى';

  @override
  String get lowStock => 'مخزون منخفض';

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get editProduct => 'تعديل منتج';

  @override
  String get deleteProduct => 'حذف المنتج';

  @override
  String get confirmDeleteProduct => 'هل أنت متأكد أنك تريد حذف هذا المنتج؟';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get fieldRequired => 'مطلوب';

  @override
  String get invalidNumber => 'رقم غير صحيح';

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
      zero: 'نفذت الكمية',
    );
    return 'السعر: $priceString | المخزون: $_temp0';
  }

  @override
  String get products => 'المنتجات';

  @override
  String get orders => 'الطلبات';

  @override
  String get total => 'الإجمالي';

  @override
  String get bill => 'الحساب';

  @override
  String get timeCost => 'تكلفة الوقت';

  @override
  String get search => 'بحث';

  @override
  String get inventory => 'المخزون';

  @override
  String get invoices => 'الفواتير';

  @override
  String get invoiceHistory => 'سجل الفواتير';

  @override
  String get completeSession => 'إنهاء الجلسة؟';

  @override
  String totalBillAmount(String amount) {
    return 'إجمالي الحساب: $amount ج.م';
  }

  @override
  String get finishAndPrint => 'إنهاء وطباعة';

  @override
  String get thankYouMessage => 'شكراً لك! ننتظر زيارتكم مرة أخرى';

  @override
  String get invoiceNumber => 'فاتورة #';

  @override
  String get noInvoicesFound => 'لم يتم العثور على فواتير';

  @override
  String get reprintInvoice => 'إعادة طباعة الفاتورة';

  @override
  String get paymentMethod => 'طريقة الدفع';

  @override
  String get cash => 'نقدي';

  @override
  String timeDuration(String duration) {
    return 'الوقت ($duration)';
  }

  @override
  String get addItems => 'إضافة أصناف';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get resume => 'استئناف';

  @override
  String get paused => 'موقوفة';

  @override
  String get analytics => 'التحليلات';

  @override
  String get name => 'الاسم';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get newCustomer => 'عميل جديد';

  @override
  String get searchCustomer => 'بحث عن عميل (الاسم أو الهاتف)';

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
  String get dataRefreshed => 'تم تحديث البيانات';

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

  @override
  String addMinutes(int minutes, String unit) {
    return '+$minutes $unit';
  }

  @override
  String get subtotalWithColon => 'المجموع الفرعي:';

  @override
  String remainingTime(String time) {
    return 'المتبقي $time';
  }

  @override
  String get checkoutAndPrint => 'إتمام وطباعة';

  @override
  String get checkoutShortcut => 'إتمام (Ctrl+S)';

  @override
  String stopSessionShortcut(String stopSession) {
    return '$stopSession (Ctrl+S)';
  }

  @override
  String get perHour => '/ساعة';

  @override
  String get rateLabel => 'المعدل';

  @override
  String get outOfStockLabel => 'نفذت الكمية';

  @override
  String stockLeft(int count) {
    return 'متبقي $count';
  }

  @override
  String get deleteProductTitle => 'حذف المنتج؟';

  @override
  String deleteProductMessage(String name) {
    return 'هل تريد حذف \"$name\" من المخزون؟';
  }

  @override
  String get deleteButton => 'حذف';

  @override
  String periodHeader(String start, String end) {
    return 'الفترة: $start - $end';
  }

  @override
  String discountsGivenValue(String amount, String currency) {
    return 'الخصومات المقدمة: $amount $currency';
  }

  @override
  String get percentSymbol => '%';

  @override
  String get errorConnection =>
      'فشل الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';

  @override
  String get errorRequestTimedOut =>
      'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get errorServer => 'خطأ في الخادم. يرجى المحاولة لاحقاً.';

  @override
  String get errorInvalidData => 'بيانات غير صالحة. يرجى المحاولة مرة أخرى.';

  @override
  String get errorGeneric => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';

  @override
  String get voidInvoiceTitle => 'إلغاء الفاتورة';

  @override
  String get voidInvoiceConfirm =>
      'هل أنت متأكد أنك تريد إلغاء هذه الفاتورة؟ سيتم حذفها من الإيراد اليومي.';

  @override
  String get voidAction => 'إلغاء الآن';

  @override
  String printFailed(String error) {
    return 'فشل الطباعة: $error';
  }

  @override
  String get noOrdersYet => 'لا توجد طلبات بعد';

  @override
  String get errorLoadingOrders => 'خطأ في تحميل الطلبات';

  @override
  String unknownProduct(String id) {
    return 'منتج غير معروف #$id';
  }

  @override
  String get filterToday => 'اليوم';

  @override
  String get filterThisMonth => 'هذا الشهر';

  @override
  String get filterLast3Months => 'آخر 3 شهور';

  @override
  String get filterThisYear => 'هذه السنة';

  @override
  String get noRoomUsageData => 'لا توجد بيانات لاستخدام الغرف.';

  @override
  String get hoursAbbr => 'س';

  @override
  String get noProductData => 'لا توجد بيانات للمنتجات.';

  @override
  String get qtySold => 'الكمية المباعة';

  @override
  String get rankSymbol => '#';

  @override
  String get printerSettings => 'إعدادات الطابعة';

  @override
  String get selectDefaultPrinter => 'اختيار الطابعة الافتراضية';

  @override
  String get testPrint => 'طباعة تجريبية';

  @override
  String get testPrintMessage => 'طباعة تجريبية من أركيد كاشير';

  @override
  String get playstation4 => 'بلايستيشن 4';

  @override
  String get playstation5 => 'بلايستيشن 5';

  @override
  String get walkIn => 'طلب سريع';

  @override
  String timeUpAlertTitle(String roomName) {
    return 'انتهى الوقت! - $roomName';
  }

  @override
  String get timeUpAlertContent => 'انتهى الوقت المحدد لهذه الجلسة.';

  @override
  String get checkout => 'محاسبة';

  @override
  String get dismiss => 'تجاهل';

  @override
  String get rooms => 'الغرف';

  @override
  String get room => 'غرفة';

  @override
  String get tables => 'الطاولات';

  @override
  String get table => 'طاولة';

  @override
  String get tableNumber => 'رقم الطاولة';

  @override
  String get tableName => 'اسم الطاولة';

  @override
  String get manageTables => 'إدارة الطاولات';

  @override
  String get status => 'الحالة';

  @override
  String get noTablesAvailable => 'لا توجد طاولات متاحة';

  @override
  String get addTablesFromSettings => 'أضف طاولات من قائمة الإعدادات';

  @override
  String errorLoadingTables(String error) {
    return 'خطأ في تحميل الطاولات: $error';
  }

  @override
  String get addTable => 'إضافة طاولة';

  @override
  String get editTable => 'تعديل طاولة';

  @override
  String get deleteTable => 'حذف طاولة';

  @override
  String deleteTableConfirmation(String tableName) {
    return 'هل أنت متأكد من حذف $tableName؟';
  }

  @override
  String get manageTablesTitle => 'إدارة الطاولات';

  @override
  String get createTableSuccess => 'تم إنشاء الطاولة بنجاح';

  @override
  String get updateTableSuccess => 'تم تحديث الطاولة بنجاح';

  @override
  String get deleteTableSuccess => 'تم حذف الطاولة بنجاح';

  @override
  String get ordersOnly => 'طلبات فقط';

  @override
  String get noTimerForTables => 'الطاولات تُحسب بالطلبات فقط';

  @override
  String get optional => 'اختياري';
}
