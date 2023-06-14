import 'package:flutter/material.dart';

@immutable
class StepperState {
  const StepperState({
    required this.currentStepIndex,
    required this.finishing,
  });

  const StepperState.initial()
      : currentStepIndex = 0,
        finishing = false;

  final int currentStepIndex;
  final bool finishing;

  @override
  bool operator ==(covariant StepperState other) {
    if (identical(this, other)) return true;

    return other.currentStepIndex == currentStepIndex && other.finishing == finishing;
  }

  @override
  int get hashCode => currentStepIndex.hashCode ^ finishing.hashCode;

  StepperState copyWith({
    int? currentStepIndex,
    bool? finishing,
  }) {
    return StepperState(
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      finishing: finishing ?? this.finishing,
    );
  }
}

class StepperController extends ValueNotifier<StepperState> {
  StepperController({
    required this.stepCount,
    this.onFinish,
  }) : super(const StepperState.initial());

  final int stepCount;

  final Future<void> Function()? onFinish;

  final scrollController = ScrollController();

  /// Current Step Index
  int get stepIndex => value.currentStepIndex;

  /// Update current step Index
  set stepIndex(int index) => value = value.copyWith(currentStepIndex: index);

  /// Check if this is the first step
  bool get isFirstStep => stepIndex == 0;

  /// Check if this is the last step
  bool get isLastStep => stepIndex == stepCount - 1;

  /// Check if the stepper is finishing
  /// i.e it the last step and finish is pressed
  bool get finishing => value.finishing;

  /// Make a step back
  ///
  /// if [isFirstStep] is true, then it will do nothing
  ///
  /// this will animate to the current step
  void stepBack() {
    if (isFirstStep) return;
    stepIndex = stepIndex - 1;
    _animateToCurrentStep();
  }

  /// Make a step forward
  ///
  /// if [isLastStep] is true, then it will update [finishing] flag to be true
  /// and call [onFinish], if passed.
  ///
  /// if [finishing] is true, it will do nothing
  ///
  /// this will animate to the current step
  Future<void> stepForward() async {
    if (finishing) return;

    if (isLastStep) {
      value = value.copyWith(finishing: true);
      await (onFinish?.call() ?? Future.value());
      value = value.copyWith(finishing: false);
      return;
    }

    stepIndex = stepIndex + 1;
    _animateToCurrentStep();
  }

  /// Handle when a step is tapped
  ///
  /// for now, only a the previous step can be navigated to
  void onStepTapped(int index) {
    if (stepIndex - index == 1) {
      stepBack();
    }
  }

  void _animateToCurrentStep() {
    // we don't need to animate
    if (stepCount <= 5) return;

    scrollController.animateTo(
      stepIndex * 40,
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceIn,
    );
  }
}
