# Claude.MD - Arcade Cashier Project Guide

## Project Overview
**Arcade Cashier** is a cross-platform Flutter management application for arcade gaming centers. It handles business operations including customer management, room/session tracking, billing, invoicing, and analytics reporting.

**Platforms**: Web, Desktop (Windows, macOS, Linux), Mobile (iOS, Android)

**Current Feature Count**: 12 features, 120+ hand-written Dart files (+ 47 generated .g.dart + 17 .freezed.dart)

## Tech Stack

### Core
- **Flutter SDK**: ^3.10.4
- **Language**: Dart
- **State Management**: `flutter_riverpod` ^2.6.1 with code generation (`riverpod_generator` ^2.6.3)
- **Backend**: `supabase_flutter` ^2.12.0 (Database + Auth)
- **Routing**: `go_router` ^17.0.1

### Key Dependencies
- **Networking**: `dio` ^5.9.1, `http` ^1.6.0
- **Models**: `freezed` ^2.5.2, `json_serializable` ^6.8.0, `freezed_annotation` ^2.4.4
- **Localization**: `flutter_localizations`, `intl` ^0.20.2 (English + Arabic with RTL)
- **UI**: `google_fonts` ^8.0.0, `fl_chart` ^1.1.1 (for charts/graphs)
- **PDF**: `pdf` ^3.11.1, `printing` ^5.14.2
- **Desktop**: `window_manager` ^0.5.1
- **Persistence**: `shared_preferences` ^2.5.4
- **Network Status**: `connectivity_plus` ^6.1.2
- **Environment**: `flutter_dotenv` ^5.1.0
- **Reactive Streams**: `rxdart` ^0.28.0
- **Audio**: `audioplayers` ^6.1.0 (sound notifications)
- **Collections**: `collection` ^1.19.1 (collection utilities)

## Architecture

### Pattern: Feature-First Architecture (CodeWithAndrea Style)
```
lib/src/
├── core/                      # Core providers and configuration
│   ├── app_router.dart        # GoRouter configuration
│   ├── supabase_provider.dart # Supabase client setup
│   ├── dio_provider.dart      # Dio HTTP client
│   └── connectivity_provider.dart
├── features/                  # Feature modules
│   ├── authentication/
│   ├── rooms/
│   ├── tables/
│   ├── sessions/
│   ├── customers/
│   ├── orders/
│   ├── products/
│   ├── billing/
│   ├── invoices/
│   ├── reports/
│   ├── shifts/
│   └── settings/
├── common_widgets/            # Reusable UI components
├── utils/                     # Helpers, formatters, extensions
├── constants/                 # App sizes, routes, themes, DB constants
└── localization/             # ARB files for translations
```

### Feature Structure (Each feature follows this pattern)
```
feature_name/
├── domain/          # Data models (Freezed classes)
├── data/            # Repositories (implement interfaces)
├── application/     # Service classes (business logic)
└── presentation/    # UI widgets and Riverpod Controllers (AsyncNotifier)
```

### Layer Responsibilities
- **Domain**: Immutable data models using Freezed
- **Data**: Repository implementations with abstract interfaces (for DIP/testability)
- **Application**: Business logic services
- **Presentation**: UI widgets (StatelessWidget) + Controllers (AsyncNotifier/Notifier)

## Coding Standards (STRICT - See project_rules.md)

### File Organization
- **Max file size**: 200 lines - must break down if exceeded
- **Widget composition**: NEVER use helper methods (`_buildWidget()`) - always create separate StatelessWidget classes in separate files if >20 lines
- **S.O.L.I.D principles**:
  - SRP: Widgets = UI only, Controllers = State, Repositories = Data
  - DIP: Repositories depend on abstractions (interfaces), not implementations

### Resource Management (ZERO Hard-Coding)
1. **Strings**: NEVER hard-code strings in UI
   - Use: `AppLocalizations.of(context).stringKey`
   - Define in: `lib/src/localization/app_en.arb` and `app_ar.arb`

2. **Routes**: NEVER use raw strings like `'/login'`
   - Define in: `lib/src/constants/app_routes.dart` (abstract class `AppRoutes`)
   - Use: `AppRoutes.loginRoute`

3. **Assets**: NEVER use raw paths like `'assets/images/logo.png'`
   - Define in: `lib/src/constants/app_constants.dart` (abstract class `AppAssets`)
   - Use: `AppAssets.logoPath`

4. **Database**: Table/column names in `lib/src/constants/db_constants.dart`

### Code Style
- **Typing**: Strict typing, avoid `dynamic` unless absolutely necessary
- **Async**: Use `AsyncValue<T>` for UI state - handle loading/error/data states
- **Constructors**: Use `const` wherever possible
- **Riverpod**: Use code generation with `@riverpod` annotation

### UI/UX Guidelines
- **Responsive Breakpoints**:
  - Mobile (Compact): < 600px
  - Tablet (Medium): 600px - 1100px
  - Desktop (Expanded): > 1100px
- **Desktop**: Use `ResponsiveCenter` to constrain content width
- **RTL Support**: Arabic language support required
- **Desktop UX**: Keyboard navigation (Tab/Enter) and hover effects
- **Theme**: Use ThemeData extensions or constants from `app_theme.dart`

## Key Files & Locations

### Entry Point
- `lib/main.dart` - App initialization, Supabase setup, window configuration

### Configuration
- `.env` - Supabase credentials (SUPABASE_URL, SUPABASE_ANON_KEY)
- `pubspec.yaml` - Dependencies and assets
- `project_rules.md` - Detailed coding standards and architecture rules
- `l10n.yaml` - Localization configuration
- `flutter_launcher_icons.yaml` - App icon configuration

### Constants
- `lib/src/constants/app_routes.dart` - Route definitions
- `lib/src/constants/app_constants.dart` - App-wide constants (assets, etc.)
- `lib/src/constants/app_sizes.dart` - Spacing/sizing constants
- `lib/src/constants/app_theme.dart` - Theme configuration (dark, PS Blue + Neon Green)
- `lib/src/constants/db_constants.dart` - Database table/column names
- `lib/src/constants/app_env.dart` - Environment config with test/prod backend switching

### Core Providers
- `lib/src/core/supabase_provider.dart` - Supabase client
- `lib/src/core/dio_provider.dart` - HTTP client
- `lib/src/core/app_router.dart` - Navigation configuration with auth/shift/admin guards
- `lib/src/core/connectivity_provider.dart` - Network status monitoring (debounced stream version)
- `lib/src/core/logging_client.dart` - HTTP request/response logging wrapper

### Localization
- `lib/src/localization/app_en.arb` - English strings (100+ keys)
- `lib/src/localization/app_ar.arb` - Arabic strings
- Generated: `lib/src/localization/app_localizations.dart` (auto-generated)

### Common Widgets
- `lib/src/common_widgets/logo_loading_indicator.dart` - Branded loading state
- `lib/src/common_widgets/offline_screen.dart` - Network offline handling
- `lib/src/common_widgets/error_state_widget.dart` - Consistent error UI with retry

### Utils & Extensions
- `lib/src/utils/go_router_refresh_stream.dart` - Stream-based router refresh
- `lib/src/utils/localization_utils.dart` - Localization helpers
- `lib/src/utils/double_extension.dart` - Number formatting
- `lib/src/utils/error_messages.dart` - User-friendly error message translation

## Features Overview

| Feature | Description |
|---------|-------------|
| **authentication** | User login, auth state management, role-based access (admin/cashier) |
| **rooms** | Manage arcade gaming rooms with hourly rates and device types (PS4/PS5) |
| **tables** | Manage cafe/game tables with session tracking (parallel to rooms) |
| **sessions** | Track gaming sessions — room-based, table-based, or quick order (no location) |
| **customers** | Customer database and management |
| **orders** | Order processing and tracking within sessions |
| **products** | Product catalog with dual-language names (EN + AR) |
| **billing** | Pricing/billing logic for open (hourly) and fixed sessions |
| **invoices** | Invoice generation with PDF support, payment method tracking, discounts |
| **reports** | Analytics dashboard with charts — revenue, room usage, products, financial breakdown |
| **shifts** | Shift management with cashier assignment, PIN security, cash reconciliation |
| **settings** | App settings, locale preferences, printer configuration |

### Session Types
- **Room session**: Linked to a specific arcade room
- **Table session**: Linked to a cafe/game table
- **Quick order**: No location, direct order only
- **Session type**: `open` (hourly billing) or `fixed` (preset duration)
- **Match type**: `single`, `multi`, or `other` (affects pricing)

### Routing & Navigation Guards
The router (`app_router.dart`) enforces a three-level guard chain:
1. **Auth guard**: Unauthenticated → `/login`
2. **Shift guard**: No active shift → `/start-shift` (skippable by admin)
3. **Admin guard**: Non-admin users cannot access analytics or management routes

Navigation uses a `StatefulShellRoute` with 6 branches; the analytics branch is conditionally hidden for non-admin users.

### Database Schema
Tables in Supabase:
- `products`, `sessions`, `invoices`, `rooms`, `tables`
- `orders`, `order_items`, `session_orders`
- `profiles` (Supabase auth extension)
- `cashiers`, `shifts`, `shift_reports_summary`

## Common Tasks

### Running the App
```bash
# Load environment variables and run
flutter run

# Run on specific platform
flutter run -d windows
flutter run -d macos
flutter run -d chrome  # For web
```

### Code Generation
```bash
# Generate Freezed, JSON serialization, and Riverpod code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerate on changes)
flutter pub run build_runner watch --delete-conflicting-outputs
```

### Localization
```bash
# Generate localization files after updating ARB files
flutter gen-l10n
```

### Icon Generation
```bash
# Generate app icons for all platforms
flutter pub run flutter_launcher_icons
```

### Adding a New Feature
1. Create folder in `lib/src/features/feature_name/`
2. Add subfolders: `domain/`, `data/`, `application/`, `presentation/`
3. Implement models in `domain/` with Freezed
4. Create repository interface + implementation in `data/`
5. Add business logic services in `application/`
6. Build UI in `presentation/` with Riverpod controllers
7. Add route in `app_routes.dart` and `app_router.dart`
8. Add localized strings in ARB files

### Adding Localized Strings
1. Add key-value to `lib/src/localization/app_en.arb`
2. Add translation to `lib/src/localization/app_ar.arb`
3. Run `flutter gen-l10n`
4. Use in code: `AppLocalizations.of(context).yourKey`

## Desktop Configuration

### Window Settings (main.dart)
- Default size: 1280x720
- Minimum size: 1024x768
- Title: "Arcade Cashier"
- Centered on launch

## Environment Variables

Required in `.env` file:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

For test/staging environments, a `.env.test` file is also supported. The `AppEnv` class in `lib/src/constants/app_env.dart` manages backend switching:
- Priority order: CI/CD environment variables → `useTestBackend` flag → fallback defaults
- `.env` and `.env.test` are loaded as Flutter assets and are gitignored

## Code References Format

When referencing code locations, use:
- Files: `[file.dart](path/to/file.dart)`
- Lines: `[file.dart:42](path/to/file.dart#L42)`
- Ranges: `[file.dart:42-51](path/to/file.dart#L42-L51)`

## Important Notes

### DO
- Follow feature-first architecture strictly
- Use Riverpod code generation (`@riverpod`)
- Implement repository interfaces for testability
- Handle all AsyncValue states (loading/error/data)
- Use localization for ALL user-facing strings
- Keep files under 200 lines
- Create separate widget classes (no helper methods)
- Use `const` constructors
- Support responsive layouts
- Test on desktop platforms (especially window behavior)

### DON'T
- Hard-code strings in UI
- Use raw route strings or asset paths
- Create helper methods that return widgets
- Use `dynamic` type unless necessary
- Exceed 200 lines per file
- Put business logic in UI widgets
- Ignore error states in AsyncValue
- Use concrete implementations in repository interfaces

## Git Info
- **Main branch**: `main`
- **Recent focus**: Shifts feature, tables feature, test backend support, invoice payment methods

## Additional Resources
- Full coding standards: `project_rules.md`
- Flutter docs: https://docs.flutter.dev/
- Riverpod docs: https://riverpod.dev/
- Supabase docs: https://supabase.com/docs
