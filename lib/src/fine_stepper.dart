import 'package:fine_stepper/src/helper_widgets/dismiss_focus_overlay.dart';
import 'package:fine_stepper/src/indicator_options.dart';
import 'package:fine_stepper/src/step_item.dart';
import 'package:flutter/material.dart';

part 'stepper_controller.dart';
part 'widgets/stepper_indicator.dart';

class _StepperProvider extends InheritedNotifier<StepperController> {
  const _StepperProvider({
    required super.child,
    super.notifier,
  });
}

/// {@template FineStepper}
/// A Stepper widget that offers an easy api for creating and managing steps
/// {@endtemplate}
class FineStepper extends StatefulWidget {
  /// {@macro FineStepper}
  @Deprecated('Default constructor is deprecated, use FineStepper.icon instead')
  const FineStepper({
    required this.steps,
    this.onFinish,
    this.indicatorOptions = const IndicatorOptions(),
    super.key,
  })  : _indicatorType = IndicatorType.icon,
        assert(steps.length != 0, 'Steps cannot be empty');

  /// {@macro FineStepper}
  const FineStepper.icon({
    required this.steps,
    this.onFinish,
    this.indicatorOptions = const IndicatorOptions(),
    super.key,
  })  : _indicatorType = IndicatorType.icon,
        assert(steps.length != 0, 'Steps cannot be empty');

  /// {@macro FineStepper}
  const FineStepper.linear({
    required this.steps,
    this.onFinish,
    this.indicatorOptions = const IndicatorOptions(),
    super.key,
  })  : _indicatorType = IndicatorType.linear,
        assert(steps.length != 0, 'Steps cannot be empty');

  /// List of [StepItem] to build at each step
  final List<StepItem> steps;

  /// {@macro StepperController.onFinish}
  final Future<void> Function()? onFinish;

  /// Options for the stepper indicator
  final IndicatorOptions indicatorOptions;

  /// Type of the indicator
  final IndicatorType _indicatorType;

  /// Get the closest [StepperController] in the widget tree
  static StepperController of(BuildContext context) {
    // ignore: prefer_asserts_with_message
    assert(_debugCheckHasStepperController(context));
    return context.dependOnInheritedWidgetOfExactType<_StepperProvider>()!.notifier!;
  }

  static bool _debugCheckHasStepperController(BuildContext context) {
    // ignore: prefer_asserts_with_message
    assert(() {
      if (context.dependOnInheritedWidgetOfExactType<_StepperProvider>() == null) {
        throw FlutterError.fromParts(<DiagnosticsNode>[
          ErrorSummary('No FineStepper widget ancestor found.'),
          ErrorDescription(
            '${context.widget.runtimeType} widgets require a FineStepper widget ancestor.',
          ),
          context.describeWidget('The specific widget that could not find a FineStepper ancestor was'),
          context.describeOwnershipChain('The ownership chain for the affected widget is'),
          ErrorHint(
            'No FineStepper ancestor could be found starting from the context '
            'that was passed to FineStepper.of(). This can happen because you '
            'have not added a FineStepper Widget '
            'or it can happen if the '
            'context you use comes from a widget above those widgets.',
          ),
        ]);
      }
      return true;
    }());
    return true;
  }

  @override
  State<FineStepper> createState() => _FineStepperState();
}

class _FineStepperState extends State<FineStepper> {
  late StepperController controller = StepperController(
    steps: widget.steps,
    indicatorOptions: widget.indicatorOptions,
    onFinish: widget.onFinish,
  );

  @override
  void didUpdateWidget(covariant FineStepper oldWidget) {
    final oldStepIndex = controller.stepIndex;
    controller = StepperController(
      steps: widget.steps,
      indicatorOptions: widget.indicatorOptions,
      onFinish: widget.onFinish,
    )..stepIndex = oldStepIndex;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget buildIndicator() {
    switch (widget._indicatorType) {
      case IndicatorType.icon:
        return const _StepperIndicator.icon();
      case IndicatorType.linear:
        return const _StepperIndicator.linear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _StepperProvider(
      notifier: controller,
      child: DismissFocusOverlay(
        child: Column(
          children: [
            buildIndicator(),
            Builder(
              // get the context that contains the controller
              builder: (context) {
                return Expanded(
                  child: controller._activeStep.builder(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
