import 'package:flutter/material.dart';

/// A branded loading indicator that displays the app logo with a smooth
/// pulse (scale + fade) animation. Use as a drop-in replacement for
/// [CircularProgressIndicator].
class LogoLoadingIndicator extends StatefulWidget {
  const LogoLoadingIndicator({super.key, this.size = 50.0});

  /// The width and height of the logo image.
  final double size;

  @override
  State<LogoLoadingIndicator> createState() => _LogoLoadingIndicatorState();
}

class _LogoLoadingIndicatorState extends State<LogoLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.6,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Gentle wobble rotation: -5° to +5°
    _rotationAnimation = Tween<double>(
      begin: -0.05,
      end: 0.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Image.asset(
              'assets/images/logo.png',
              width: widget.size,
              height: widget.size,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
