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
}
