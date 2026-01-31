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
}
