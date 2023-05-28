import 'package:fine_stepper/src/helper_widgets/form_builder.dart';
import 'package:fine_stepper/src/stepper_controls.dart';
import 'package:flutter/material.dart';

/// Layout for [StepBuilder] and [StepperControls]
///
/// when [StepLayout.column], step content and controls will be laid out in a column,
/// taking the minimum height
///
/// when [StepLayout.stack], step content will take the available height,
/// and controls will be stacked on top of the content, aligned to bottomCenter
enum StepLayout {
  column,
  stack,
}

/// {@template StepBuilder}
/// StepBuilder
/// {@endtemplate}
class StepBuilder extends StatelessWidget {
  /// {@macro StepBuilder}
  const StepBuilder({
    required this.child,
    this.layout = StepLayout.stack,
    this.childAlignment = Alignment.topCenter,
    this.padding,
    this.shouldStepForward,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// {@template StepBuilder.layout}
  /// layout for the child and [StepperControls]
  /// {@endtemplate}
  final StepLayout layout;

  /// {@template StepBuilder.childAlignment}
  /// Child alignment when layout is [StepLayout.stack],
  ///
  /// defaults to [Alignment.center]
  /// {@endtemplate}
  final Alignment childAlignment;

  final EdgeInsets? padding;

  final bool Function()? shouldStepForward;

  @override
  Widget build(BuildContext context) {
    switch (layout) {
      case StepLayout.stack:
        return Stack(
          children: [
            Align(
              alignment: childAlignment,
              child: child,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: StepperControls(shouldStepForward: shouldStepForward),
              ),
            ),
          ],
        );

      case StepLayout.column:
        return SingleChildScrollView(
          child: Column(
            children: [
              child,
              Padding(
                padding: padding ?? const EdgeInsets.all(16),
                child: StepperControls(shouldStepForward: shouldStepForward),
              ),
            ],
          ),
        );
    }
  }
}

/// {@template FormStepBuilder}
/// A variant of StepBuilder that steps forward only if the current form content is validated
/// {@endtemplate}
class FormStepBuilder extends StatelessWidget {
  /// {@macro FormStepBuilder}
  const FormStepBuilder({
    required this.child,
    this.layout = StepLayout.stack,
    this.childAlignment = Alignment.topCenter,
    this.padding,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// {@macro StepBuilder.layout}
  final StepLayout layout;

  /// {@macro StepBuilder.childAlignment}
  final Alignment childAlignment;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      builder: (validateAndSaveForm) {
        return StepBuilder(
          childAlignment: childAlignment,
          layout: layout,
          shouldStepForward: validateAndSaveForm,
          padding: padding,
          child: child,
        );
      },
    );
  }
}
