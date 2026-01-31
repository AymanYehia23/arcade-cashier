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
  String get twoPlayers => '2 Players';

  @override
  String get fourPlayers => '4 Players';
}
