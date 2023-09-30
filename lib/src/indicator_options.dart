import 'package:flutter/material.dart';

/// {@template IndicatorBehavior}
/// How the indicator behaves when the content is wider than the screen
///
/// **fit**: fit all indicator signs to the available width
///
/// **scroll**: give all indicator signs a fixed width and let it scroll
/// {@endtemplate}
enum IndicatorBehavior {
  /// fit all indicator signs to the available width
  fit,

  /// give all indicator signs a fixed width and let it scroll
  scroll,
}

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
    this.behavior = IndicatorBehavior.fit,
  });

  /// Step Color when active, default to [ColorScheme.primary]
  final Color? activeStepColor;

  /// Step Color when completed, default to [ColorScheme.primary]
  final Color? completedStepColor;

  /// default Step Color, default to [Colors.grey[400]]
  final Color? stepColor;

  /// Indicator paddings
  final EdgeInsets padding;

  /// {@macro IndicatorBehavior}
  ///
  /// has no effect when using FineStepper.linear
  final IndicatorBehavior behavior;
}
