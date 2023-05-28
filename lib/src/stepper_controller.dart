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

  final Future<void> Function()? onFinish;

  final scrollController = ScrollController();

  final int stepCount;

  int get stepIndex => value.currentStepIndex;
  set stepIndex(int index) => value = value.copyWith(currentStepIndex: index);

  bool get isFirstStep => stepIndex != 0;
  bool get isLastStep => stepIndex == stepCount - 1;

  bool get finishing => value.finishing;

  void stepBack() {
    if (stepIndex == 0) return;
    stepIndex = stepIndex - 1;
    _animateToCurrentStep();
  }

  Future<void> stepForward() async {
    if (isLastStep) {
      value = value.copyWith(finishing: true);
      await (onFinish?.call() ?? Future.value());
      value = value.copyWith(finishing: false);
      return;
    }

    stepIndex = stepIndex + 1;
    _animateToCurrentStep();
  }

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
