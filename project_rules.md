# Project: Arcade Cashier (Manager App)

## 1. Architecture & Folder Structure
**Style:** Feature-First, Riverpod Architecture (CodeWithAndrea style).
**Root:** `lib/src/`
- **`features/`**: Contains feature-based modules (e.g., `authentication`, `dashboard`, `rooms`, `sessions`, `settings`).
  - Inside each feature:
    - `/domain`: Data models (Freezed classes).
    - `/data`: Repositories (Data access logic). Implement Repository Interface.
    - `/application`: Service classes (Business logic).
    - `/presentation`: UI widgets and Riverpod Controllers (`AsyncNotifier`).
- **`common_widgets/`**: Reusable UI components (Buttons, Cards, `ResponsiveCenter`).
- **`utils/`**: Helpers, formatters, and extensions.
- **`constants/`**: App sizes, breakpoints, theme config.
- **`localization/`**: Translation logic (l10n).

## 2. Tech Stack & Packages
- **State Management:** `flutter_riverpod` (v2.x) with code generation (`riverpod_generator`).
- **Backend:** `supabase_flutter` (for Database/Auth).
- **Networking:** `dio` (For external API calls or Edge Functions).
- **Routing:** `go_router` (Supports Web/Desktop URL navigation).
- **Localization:** `flutter_localizations` with ARB files (English & Arabic).
- **Responsiveness:** `flutter_adaptive_scaffold` or `layout_builder`.
- **Desktop/Web:** `window_manager` (for window sizing), `shared_preferences` (persistence).
- **Models:** `freezed` & `json_serializable`.

## 3. Coding Standards (Strict)
- **UI Composition:** NEVER use helper methods (e.g., `_buildHeader()`) to return Widgets. ALWAYS create a separate `StatelessWidget` class in a separate file if it exceeds 20 lines.
- **File Size:** No file should exceed 200 lines. Break it down.
- **S.O.L.I.D:**
  - **DIP:** Repositories must depend on abstractions/interfaces, not concrete implementations (useful for mocking).
  - **SRP:** Widgets only handle UI. Controllers handle State. Repositories handle Data.
- **Async:** Use `AsyncValue` for UI state (loading, error, data). Handle all states gracefully.
- **Typing:** Strict typing. No `dynamic` unless absolutely necessary.

## 4. Resource Management (Zero Hard-Coding)
- **Strings:** NEVER use hard-coded strings in Text widgets or logic. All strings must be defined in `AppLocalizations` (ARB files).
- **Routes:** Route names and paths must be defined as constants in an abstract class (`AppRoutes`). Never type a raw route string like `'/login'` in GoRouter configuration or navigation calls.
- **Assets:** Image and SVG paths must be centralized in an abstract class (`AppAssets`). Never use raw string paths like `'assets/images/logo.png'` directly in widgets.

## 5. UI/UX Guidelines
- **Responsive:** The UI must adapt to:
  - Mobile (Compact): < 600px
  - Tablet (Medium): 600px - 1100px
  - Desktop (Expanded): > 1100px
- **Layout:** On Desktop/Web, content must be constrained. Use `ResponsiveCenter` widget to prevent full-width stretching on large screens.
- **Language:** Support RTL (Right-to-Left) for Arabic explicitly.
- **Theme:** Use `ThemeData` extensions or strict Color/Text constants. No hardcoded colors/sizes in widgets.
- **Desktop UX:** Support Keyboard Navigation (Tab/Enter) and Hover effects on interactive cards.

## 6. Agent Instructions
- **Review:** Before generating code, review these rules.
- **Output:** When generating files, provide the full path (e.g., `lib/src/features/auth/data/auth_repository.dart`).
- **Clean Code:** Use `const` constructors wherever possible.