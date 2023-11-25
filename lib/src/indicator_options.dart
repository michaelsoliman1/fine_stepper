import 'package:flutter/material.dart';

/// {@template IndicatorOptions}
/// Options for Stepper Indicator
/// {@endtemplate}
class IndicatorOptions {
  /// {@macro IndicatorOptions}
  const IndicatorOptions({
    this.activeStepColor,
    this.completedStepColor,
    this.stepColor,
    this.padding = const EdgeInsets.all(16),
    this.scrollable = false,
  });

  /// Step Color when active, default to [ColorScheme.primary]
  final Color? activeStepColor;

  /// Step Color when completed, default to [ColorScheme.primary]
  final Color? completedStepColor;

  /// default Step Color, default to [Colors.grey[400]]
  final Color? stepColor;

  /// Indicator paddings
  final EdgeInsets padding;

  /// whether the indicator scrolls or not
  ///
  /// has no effect when using FineStepper.linear
  final bool scrollable;
}
