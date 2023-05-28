import 'package:flutter/material.dart';

class StepperController extends ValueNotifier<int> {
  StepperController({
    required this.stepCount,
    this.onFinish,
  }) : super(0);

  final VoidCallback? onFinish;

  final scrollController = ScrollController();

  final int stepCount;

  int get stepIndex => value;
  set stepIndex(int index) => value = index;

  bool get isFirstStep => stepIndex != 0;
  bool get isLastStep => stepIndex == stepCount - 1;

  void stepBack() {
    if (stepIndex == 0) return;
    stepIndex = stepIndex - 1;
    _animateToCurrentStep();
  }

  void stepForward({dynamic arg}) {
    if (isLastStep) {
      onFinish?.call();
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
