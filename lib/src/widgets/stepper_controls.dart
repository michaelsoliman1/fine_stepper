import 'package:fine_stepper/src/fine_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template StepperControls}
/// Simple Controls that offers `back, next` buttons
/// for navigating through steps
///
/// if this is the last step, then next button will become finish
/// {@endtemplate}
class StepperControls extends StatelessWidget {
  /// {@macro StepperControls}
  const StepperControls({
    this.shouldStepForward,
    super.key,
  });

  /// If we should continue to the next step
  ///
  /// useful if you need to validate a form before stepping forward
  final bool Function()? shouldStepForward;

  @override
  Widget build(BuildContext context) {
    final controller = FineStepper.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(disabledBackgroundColor: Colors.grey[400]),
          onPressed: controller.isFirstStep ? null : controller.stepBack,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.navigate_before),
              SizedBox(width: 5),
              Flexible(child: Text('Back')),
              SizedBox(width: 10),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (shouldStepForward?.call() ?? true) {
              FineStepper.of(context).stepForward();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
          ),
          child: controller.isLastStep
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    const Flexible(child: Text('Finish')),
                    const SizedBox(width: 5),
                    if (controller.finishing) //
                      CupertinoActivityIndicator(color: Theme.of(context).colorScheme.onPrimary)
                    else
                      const Icon(Icons.done)
                  ],
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(width: 10),
                    Flexible(child: Text('Next')),
                    SizedBox(width: 5),
                    Icon(Icons.navigate_next),
                  ],
                ),
        ),
      ],
    );
  }
}
