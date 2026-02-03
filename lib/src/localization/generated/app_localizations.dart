import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Arcade Shop ERP'**
  String get appTitle;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'Arcade'**
  String get brandName;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Login to Arcade Shop'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Failed to login. Please check your credentials.'**
  String get loginError;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequired;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get statusAvailable;

  /// No description provided for @statusOccupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied'**
  String get statusOccupied;

  /// No description provided for @statusMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get statusMaintenance;

  /// No description provided for @statusHeld.
  ///
  /// In en, this message translates to:
  /// **'Held'**
  String get statusHeld;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @manageRooms.
  ///
  /// In en, this message translates to:
  /// **'Manage Rooms'**
  String get manageRooms;

  /// No description provided for @addRoom.
  ///
  /// In en, this message translates to:
  /// **'Add Room'**
  String get addRoom;

  /// No description provided for @editRoom.
  ///
  /// In en, this message translates to:
  /// **'Edit Room'**
  String get editRoom;

  /// No description provided for @deleteRoom.
  ///
  /// In en, this message translates to:
  /// **'Delete Room'**
  String get deleteRoom;

  /// No description provided for @roomName.
  ///
  /// In en, this message translates to:
  /// **'Room Name'**
  String get roomName;

  /// No description provided for @deviceType.
  ///
  /// In en, this message translates to:
  /// **'Device Type'**
  String get deviceType;

  /// No description provided for @hourlyRate.
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get hourlyRate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this room?'**
  String get confirmDelete;

  /// No description provided for @roomSaved.
  ///
  /// In en, this message translates to:
  /// **'Room saved successfully'**
  String get roomSaved;

  /// No description provided for @roomDeleted.
  ///
  /// In en, this message translates to:
  /// **'Room deleted successfully'**
  String get roomDeleted;

  /// No description provided for @singleRate.
  ///
  /// In en, this message translates to:
  /// **'Single Rate'**
  String get singleRate;

  /// No description provided for @multiRate.
  ///
  /// In en, this message translates to:
  /// **'Multi Rate'**
  String get multiRate;

  /// No description provided for @twoPlayers.
  ///
  /// In en, this message translates to:
  /// **'2 Players'**
  String get twoPlayers;

  /// No description provided for @fourPlayers.
  ///
  /// In en, this message translates to:
  /// **'4 Players'**
  String get fourPlayers;

  /// No description provided for @startSession.
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get startSession;

  /// No description provided for @stopSession.
  ///
  /// In en, this message translates to:
  /// **'Stop Session'**
  String get stopSession;

  /// No description provided for @timeElapsed.
  ///
  /// In en, this message translates to:
  /// **'Time Elapsed'**
  String get timeElapsed;

  /// No description provided for @singleMatch.
  ///
  /// In en, this message translates to:
  /// **'Single Match'**
  String get singleMatch;

  /// No description provided for @multiMatch.
  ///
  /// In en, this message translates to:
  /// **'Multi Match'**
  String get multiMatch;

  /// No description provided for @activeSession.
  ///
  /// In en, this message translates to:
  /// **'Active Session'**
  String get activeSession;

  /// No description provided for @openTime.
  ///
  /// In en, this message translates to:
  /// **'Open Time'**
  String get openTime;

  /// No description provided for @fixedTime.
  ///
  /// In en, this message translates to:
  /// **'Fixed Time'**
  String get fixedTime;

  /// No description provided for @extendTime.
  ///
  /// In en, this message translates to:
  /// **'Extend Time'**
  String get extendTime;

  /// No description provided for @timeUp.
  ///
  /// In en, this message translates to:
  /// **'TIME UP!'**
  String get timeUp;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutes;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @manageInventory.
  ///
  /// In en, this message translates to:
  /// **'Manage Inventory'**
  String get manageInventory;

  /// No description provided for @noRoomsFound.
  ///
  /// In en, this message translates to:
  /// **'No rooms found'**
  String get noRoomsFound;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection validation failed. Please try again.'**
  String get connectionError;

  /// No description provided for @errorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorMessage(String error);

  /// No description provided for @sessionStopped.
  ///
  /// In en, this message translates to:
  /// **'Session stopped'**
  String get sessionStopped;

  /// No description provided for @noActiveSessionFound.
  ///
  /// In en, this message translates to:
  /// **'No active session found.'**
  String get noActiveSessionFound;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @sellingPrice.
  ///
  /// In en, this message translates to:
  /// **'Selling Price'**
  String get sellingPrice;

  /// No description provided for @stockQuantity.
  ///
  /// In en, this message translates to:
  /// **'Stock Quantity'**
  String get stockQuantity;

  /// No description provided for @drinks.
  ///
  /// In en, this message translates to:
  /// **'Drinks'**
  String get drinks;

  /// No description provided for @snacks.
  ///
  /// In en, this message translates to:
  /// **'Snacks'**
  String get snacks;

  /// No description provided for @food.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @lowStock.
  ///
  /// In en, this message translates to:
  /// **'Low Stock'**
  String get lowStock;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @confirmDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get confirmDeleteProduct;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get fieldRequired;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @productPriceStock.
  ///
  /// In en, this message translates to:
  /// **'Price: {price} | Stock: {stock, plural, =0{Out of Stock} other{{stock}}}'**
  String productPriceStock(double price, int stock);

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @bill.
  ///
  /// In en, this message translates to:
  /// **'Bill'**
  String get bill;

  /// No description provided for @timeCost.
  ///
  /// In en, this message translates to:
  /// **'Time Cost'**
  String get timeCost;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @inventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// No description provided for @invoices.
  ///
  /// In en, this message translates to:
  /// **'Invoices'**
  String get invoices;

  /// No description provided for @invoiceHistory.
  ///
  /// In en, this message translates to:
  /// **'Invoice History'**
  String get invoiceHistory;

  /// No description provided for @completeSession.
  ///
  /// In en, this message translates to:
  /// **'Complete Session?'**
  String get completeSession;

  /// No description provided for @totalBillAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Bill: {amount} EGP'**
  String totalBillAmount(String amount);

  /// No description provided for @finishAndPrint.
  ///
  /// In en, this message translates to:
  /// **'Finish & Print'**
  String get finishAndPrint;

  /// No description provided for @thankYouMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Visit again'**
  String get thankYouMessage;

  /// No description provided for @invoiceNumber.
  ///
  /// In en, this message translates to:
  /// **'Invoice #'**
  String get invoiceNumber;

  /// No description provided for @noInvoicesFound.
  ///
  /// In en, this message translates to:
  /// **'No invoices found'**
  String get noInvoicesFound;

  /// No description provided for @reprintInvoice.
  ///
  /// In en, this message translates to:
  /// **'Reprint Invoice'**
  String get reprintInvoice;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @timeDuration.
  ///
  /// In en, this message translates to:
  /// **'Time ({duration})'**
  String timeDuration(String duration);

  /// No description provided for @addItems.
  ///
  /// In en, this message translates to:
  /// **'Add Items'**
  String get addItems;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get paused;

  /// No description provided for @analytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @newCustomer.
  ///
  /// In en, this message translates to:
  /// **'New Customer'**
  String get newCustomer;

  /// No description provided for @searchCustomer.
  ///
  /// In en, this message translates to:
  /// **'Search Customer (Name or Phone)'**
  String get searchCustomer;

  /// No description provided for @endShift.
  ///
  /// In en, this message translates to:
  /// **'End Shift'**
  String get endShift;

  /// No description provided for @quickOrder.
  ///
  /// In en, this message translates to:
  /// **'Quick Order'**
  String get quickOrder;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something Went Wrong'**
  String get somethingWentWrong;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @discountLabel.
  ///
  /// In en, this message translates to:
  /// **'Discount (%)'**
  String get discountLabel;

  /// No description provided for @discountValue.
  ///
  /// In en, this message translates to:
  /// **'Discount: - {amount} EGP'**
  String discountValue(String amount);

  /// No description provided for @sessionCompleted.
  ///
  /// In en, this message translates to:
  /// **'Session completed - Invoice created'**
  String get sessionCompleted;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @egp.
  ///
  /// In en, this message translates to:
  /// **'EGP'**
  String get egp;

  /// No description provided for @egpPerHour.
  ///
  /// In en, this message translates to:
  /// **'EGP/hr'**
  String get egpPerHour;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports & Analytics'**
  String get reportsTitle;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @tabRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get tabRevenue;

  /// No description provided for @tabFinancials.
  ///
  /// In en, this message translates to:
  /// **'Financials'**
  String get tabFinancials;

  /// No description provided for @tabProducts.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get tabProducts;

  /// No description provided for @tabRoomUsage.
  ///
  /// In en, this message translates to:
  /// **'Room Usage'**
  String get tabRoomUsage;

  /// No description provided for @endOfShiftReport.
  ///
  /// In en, this message translates to:
  /// **'End of Shift Report'**
  String get endOfShiftReport;

  /// No description provided for @cashSales.
  ///
  /// In en, this message translates to:
  /// **'Cash Sales'**
  String get cashSales;

  /// No description provided for @cardSales.
  ///
  /// In en, this message translates to:
  /// **'Card Sales'**
  String get cardSales;

  /// No description provided for @totalTransactions.
  ///
  /// In en, this message translates to:
  /// **'Total Transactions'**
  String get totalTransactions;

  /// No description provided for @netRevenue.
  ///
  /// In en, this message translates to:
  /// **'Net Revenue'**
  String get netRevenue;

  /// No description provided for @discountsGiven.
  ///
  /// In en, this message translates to:
  /// **'Discounts Given'**
  String get discountsGiven;

  /// No description provided for @printZReport.
  ///
  /// In en, this message translates to:
  /// **'Print Z-Report'**
  String get printZReport;

  /// No description provided for @failedToLoadReport.
  ///
  /// In en, this message translates to:
  /// **'Failed to load shift report'**
  String get failedToLoadReport;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @failedToPrintReport.
  ///
  /// In en, this message translates to:
  /// **'Failed to print report: {error}'**
  String failedToPrintReport(String error);

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'CANCELLED'**
  String get cancelled;

  /// No description provided for @invoiceNum.
  ///
  /// In en, this message translates to:
  /// **'Invoice #'**
  String get invoiceNum;

  /// No description provided for @tableItem.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get tableItem;

  /// No description provided for @tableQty.
  ///
  /// In en, this message translates to:
  /// **'Qty'**
  String get tableQty;

  /// No description provided for @tableAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get tableAmount;

  /// No description provided for @subtotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotalLabel;

  /// No description provided for @discountLabelPdf.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discountLabelPdf;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'TOTAL'**
  String get totalLabel;

  /// No description provided for @thankYou.
  ///
  /// In en, this message translates to:
  /// **'Thank you!'**
  String get thankYou;

  /// No description provided for @visitAgain.
  ///
  /// In en, this message translates to:
  /// **'Visit again'**
  String get visitAgain;

  /// No description provided for @cashierSignature.
  ///
  /// In en, this message translates to:
  /// **'Cashier Signature'**
  String get cashierSignature;

  /// No description provided for @zReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Z-REPORT'**
  String get zReportTitle;

  /// No description provided for @paymentCash.
  ///
  /// In en, this message translates to:
  /// **'CASH'**
  String get paymentCash;

  /// No description provided for @paymentCard.
  ///
  /// In en, this message translates to:
  /// **'CARD'**
  String get paymentCard;

  /// No description provided for @noRevenueData.
  ///
  /// In en, this message translates to:
  /// **'No revenue data available.'**
  String get noRevenueData;

  /// No description provided for @grossSales.
  ///
  /// In en, this message translates to:
  /// **'Gross Sales'**
  String get grossSales;

  /// No description provided for @profitabilityBySource.
  ///
  /// In en, this message translates to:
  /// **'Profitability by Source'**
  String get profitabilityBySource;

  /// No description provided for @tableSource.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get tableSource;

  /// No description provided for @tableSessions.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get tableSessions;

  /// No description provided for @tableHours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get tableHours;

  /// No description provided for @tableRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get tableRevenue;

  /// No description provided for @avgTicket.
  ///
  /// In en, this message translates to:
  /// **'Avg. Ticket'**
  String get avgTicket;

  /// No description provided for @grandTotalRevenue.
  ///
  /// In en, this message translates to:
  /// **'Grand Total Revenue: '**
  String get grandTotalRevenue;

  /// No description provided for @noDataPeriod.
  ///
  /// In en, this message translates to:
  /// **'No data available for this period.'**
  String get noDataPeriod;

  /// No description provided for @discountsLabel.
  ///
  /// In en, this message translates to:
  /// **'Discounts'**
  String get discountsLabel;

  /// No description provided for @addMinutes.
  ///
  /// In en, this message translates to:
  /// **'+{minutes} {unit}'**
  String addMinutes(int minutes, String unit);

  /// No description provided for @subtotalWithColon.
  ///
  /// In en, this message translates to:
  /// **'Subtotal:'**
  String get subtotalWithColon;

  /// No description provided for @remainingTime.
  ///
  /// In en, this message translates to:
  /// **'{time} remaining'**
  String remainingTime(String time);

  /// No description provided for @checkoutAndPrint.
  ///
  /// In en, this message translates to:
  /// **'Checkout & Print'**
  String get checkoutAndPrint;

  /// No description provided for @checkoutShortcut.
  ///
  /// In en, this message translates to:
  /// **'Checkout (Ctrl+S)'**
  String get checkoutShortcut;

  /// No description provided for @stopSessionShortcut.
  ///
  /// In en, this message translates to:
  /// **'{stopSession} (Ctrl+S)'**
  String stopSessionShortcut(String stopSession);

  /// No description provided for @perHour.
  ///
  /// In en, this message translates to:
  /// **'/hr'**
  String get perHour;

  /// No description provided for @rateLabel.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rateLabel;

  /// No description provided for @outOfStockLabel.
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStockLabel;

  /// No description provided for @stockLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} Left'**
  String stockLeft(int count);

  /// No description provided for @deleteProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product?'**
  String get deleteProductTitle;

  /// No description provided for @deleteProductMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from inventory?'**
  String deleteProductMessage(String name);

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @periodHeader.
  ///
  /// In en, this message translates to:
  /// **'Period: {start} - {end}'**
  String periodHeader(String start, String end);

  /// No description provided for @discountsGivenValue.
  ///
  /// In en, this message translates to:
  /// **'Discounts Given: {amount} {currency}'**
  String discountsGivenValue(String amount, String currency);

  /// No description provided for @percentSymbol.
  ///
  /// In en, this message translates to:
  /// **'%'**
  String get percentSymbol;

  /// No description provided for @errorConnection.
  ///
  /// In en, this message translates to:
  /// **'Unable to connect to server. Please check your internet connection.'**
  String get errorConnection;

  /// No description provided for @errorRequestTimedOut.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get errorRequestTimedOut;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorInvalidData.
  ///
  /// In en, this message translates to:
  /// **'Invalid data received. Please try again.'**
  String get errorInvalidData;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get errorGeneric;

  /// No description provided for @voidInvoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Void Invoice'**
  String get voidInvoiceTitle;

  /// No description provided for @voidInvoiceConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to void this invoice? This will remove it from daily revenue.'**
  String get voidInvoiceConfirm;

  /// No description provided for @voidAction.
  ///
  /// In en, this message translates to:
  /// **'Void'**
  String get voidAction;

  /// No description provided for @printFailed.
  ///
  /// In en, this message translates to:
  /// **'Print failed: {error}'**
  String printFailed(String error);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
