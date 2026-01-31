import 'package:arcade_cashier/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// A widget that centers its child and constrains its width to a maximum value.
/// This is useful for large screens (Desktop/Web) to prevent content from
/// stretching too wide.
class ResponsiveCenter extends StatelessWidget {
  const ResponsiveCenter({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.maxContentWidth = Breakpoint.desktop,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double maxContentWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
