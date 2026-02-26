import 'package:flutter/material.dart';
import 'package:arcade_cashier/src/localization/generated/app_localizations.dart';

/// A secure 4-digit PIN entry keypad widget.
/// Displays dots for each entered digit and a numeric grid.
class PinKeypadWidget extends StatefulWidget {
  const PinKeypadWidget({
    super.key,
    required this.onPinComplete,
    this.title,
    this.errorText,
  });

  /// Called when the user has entered all 4 digits.
  final void Function(String pin) onPinComplete;

  /// Optional title displayed above the dots.
  final String? title;

  /// Optional error text (e.g. "Wrong PIN").
  final String? errorText;

  @override
  State<PinKeypadWidget> createState() => _PinKeypadWidgetState();
}

class _PinKeypadWidgetState extends State<PinKeypadWidget>
    with SingleTickerProviderStateMixin {
  String _pin = '';
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void didUpdateWidget(PinKeypadWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Shake when error appears
    if (widget.errorText != null &&
        widget.errorText != oldWidget.errorText &&
        widget.errorText!.isNotEmpty) {
      _shakeController.forward().then((_) => _shakeController.reverse());
      setState(() => _pin = '');
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _onDigitPressed(String digit) {
    if (_pin.length >= 4) return;
    setState(() => _pin += digit);
    if (_pin.length == 4) {
      widget.onPinComplete(_pin);
    }
  }

  void _onBackspace() {
    if (_pin.isEmpty) return;
    setState(() => _pin = _pin.substring(0, _pin.length - 1));
  }

  void _onClear() {
    setState(() => _pin = '');
  }

  /// Converts a Western digit character to its Arabic-Indic equivalent.
  String _localizeDigit(String digit, bool isArabic) {
    if (!isArabic) return digit;
    const western = '0123456789';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    final index = western.indexOf(digit);
    return index >= 0 ? arabic[index] : digit;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.title != null) ...[
          Text(
            widget.title!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // PIN dots
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              final isFilled = index < _pin.length;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isFilled
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  border: Border.all(
                    color:
                        widget.errorText != null && widget.errorText!.isNotEmpty
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
              );
            }),
          ),
        ),

        // Error text
        if (widget.errorText != null && widget.errorText!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            widget.errorText!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Number grid
        SizedBox(
          width: 280,
          child: Column(
            children: [
              _buildRow(['1', '2', '3'], isArabic, isRtl, loc),
              const SizedBox(height: 12),
              _buildRow(['4', '5', '6'], isArabic, isRtl, loc),
              const SizedBox(height: 12),
              _buildRow(['7', '8', '9'], isArabic, isRtl, loc),
              const SizedBox(height: 12),
              _buildRow(['C', '0', '⌫'], isArabic, isRtl, loc),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(
    List<String> keys,
    bool isArabic,
    bool isRtl,
    AppLocalizations loc,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        if (key == '⌫') {
          return _KeyButton(
            onTap: _onBackspace,
            child: Icon(
              isRtl ? Icons.backspace_outlined : Icons.backspace_outlined,
              size: 22,
              textDirection: isRtl ? TextDirection.ltr : null,
            ),
          );
        }
        if (key == 'C') {
          return _KeyButton(
            onTap: _onClear,
            child: Text(
              isArabic ? loc.clear : key,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          );
        }
        return _KeyButton(
          onTap: () => _onDigitPressed(key),
          child: Text(
            _localizeDigit(key, isArabic),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        );
      }).toList(),
    );
  }
}

class _KeyButton extends StatelessWidget {
  const _KeyButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 56,
      child: Material(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
