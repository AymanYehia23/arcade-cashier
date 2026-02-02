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
}
