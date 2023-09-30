import 'package:fine_stepper/src/fine_stepper.dart';
import 'package:fine_stepper/src/widgets/step_builders.dart';
import 'package:flutter/material.dart';

/// {@template StepItem}
/// A step item that build the content of the step
/// {@endtemplate}
class StepItem {
  /// {@macro StepItem}
  @Deprecated('default constructor is deprecated, use StepItem.icon instead')
  const StepItem({
    required this.builder,
  })  : iconBuilder = null,
        title = null,
        description = null;

  /// Create a [StepItem] for [FineStepper.icon]
  const StepItem.icon({
    required this.builder,
    this.iconBuilder,
  })  : title = null,
        description = null;

  /// Create a [StepItem] for [FineStepper.linear]
  const StepItem.linear({
    required this.builder,
    required String this.title,
    this.description,
  }) : iconBuilder = null;

  /// Title for this step
  final String? title;

  /// Optional description for this step
  final String? description;

  /// Content Builder for this step
  ///
  /// usually a [StepBuilder] or [FormStepBuilder], but can be any custom widget
  /// for complex layout
  final Widget Function(BuildContext context) builder;

  /// Custom icon builder for this step
  ///
  /// default to the step number
  final Widget Function(BuildContext context)? iconBuilder;
}
