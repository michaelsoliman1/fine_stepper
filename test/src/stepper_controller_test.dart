import 'dart:async';

import 'package:fine_stepper/fine_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final steps = <StepItem>[
    StepItem.icon(
      builder: (context) => const Text('Step 1'),
    ),
  ];

  test(
    'Correct Initial State',
    () async {
      final controller = StepperController(steps: steps);
      expect(controller.value, const StepperState.initial());
    },
  );

  test(
    'Updates StepIndex with valid value',
    () async {
      final controller = StepperController(steps: steps);
      expect(
        () => controller.stepIndex = 4,
        throwsAssertionError,
      );
    },
  );

  test(
    'isFirstStep return correct value',
    () async {
      final controller = StepperController(steps: steps);
      expect(controller.isFirstStep, true);
    },
  );

  test(
    'isLastStep return correct value',
    () async {
      final controller = StepperController(steps: steps);
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      expect(controller.isLastStep, true);
    },
  );

  test(
    'stepBack updates stepIndex correctly',
    () async {
      final controller = StepperController(steps: steps);
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      for (var i = steps.length - 1; i >= 0; i--) {
        expect(controller.stepIndex, i);
        controller.stepBack();
      }
    },
  );

  test(
    'stepBack does not decrement stepIndex when first step',
    () async {
      final controller = StepperController(steps: steps);

      // ignore: cascade_invocations
      controller.stepBack();
      expect(controller.stepIndex, 0);
    },
  );

  test(
    'stepForward updates stepIndex correctly',
    () async {
      final controller = StepperController(steps: steps);
      for (var i = 0; i < steps.length; i++) {
        expect(controller.stepIndex, i);
        await controller.stepForward();
      }
    },
  );

  test(
    'stepForward does not increment stepIndex when last step',
    () async {
      final controller = StepperController(steps: steps);
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      expect(controller.stepIndex, steps.length - 1);
      await controller.stepForward();
      expect(controller.stepIndex, steps.length - 1);
    },
  );

  test(
    'stepForward does not increment stepIndex when finishing is true',
    () async {
      final controller = StepperController(steps: steps);
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      expect(controller.stepIndex, steps.length - 1);
      unawaited(controller.stepForward());
      expect(controller.stepIndex, steps.length - 1);
    },
  );

  test(
    'stepForward does not call onFinish when finishing is true',
    () async {
      var onFinishCalledCount = 0;
      final controller = StepperController(
        steps: steps,
        onFinish: () async {
          await Future<void>.delayed(const Duration(seconds: 1));
          onFinishCalledCount++;
        },
      );
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      expect(onFinishCalledCount, 1);
      unawaited(controller.stepForward());
      expect(onFinishCalledCount, 1);
    },
  );

  test(
    'Calls onFinish when last step',
    () async {
      var onFinishCalled = false;
      final controller = StepperController(
        steps: steps,
        onFinish: () async => onFinishCalled = true,
      );
      for (var i = 0; i < steps.length; i++) {
        await controller.stepForward();
      }
      expect(onFinishCalled, true);
    },
  );
}
