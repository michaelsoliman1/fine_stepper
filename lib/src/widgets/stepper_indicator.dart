part of '../fine_stepper.dart';

/// UI Type for the indicator
enum IndicatorType {
  /// Icons Indicator
  icon,

  /// Linear Indicator
  linear,
}

abstract class _StepperIndicator extends StatelessWidget {
  const _StepperIndicator();

  const factory _StepperIndicator.icon() = _StepperIconIndicator;
  const factory _StepperIndicator.linear() = _StepperLinearIndicator;
}

class _StepperIconIndicator extends _StepperIndicator {
  const _StepperIconIndicator();

  @override
  Widget build(BuildContext context) {
    final controller = FineStepper.of(context);
    final options = controller.indicatorOptions;
    final currentStepIndex = controller.stepIndex;

    final separatorWidth =
        (MediaQuery.sizeOf(context).width - (32 * controller.stepCount) - (2 * options.padding.left)) /
            (controller.stepCount - 1);

    return SizedBox(
      height: 80,
      child: ListView.separated(
        controller: controller._scrollController,
        padding: options.padding,
        itemCount: controller.stepCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(
          width: options.scrollable ? 60 : separatorWidth,
          child: const Divider(
            indent: 4,
            endIndent: 4,
          ),
        ),
        itemBuilder: (context, index) {
          final isCompleted = index < currentStepIndex;
          final isPrev = index == currentStepIndex - 1;

          return GestureDetector(
            onTap: isPrev ? controller.stepBack : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getStepColor(context, index),
              ),
              child: AnimatedCrossFade(
                firstChild: SizedBox.square(
                  dimension: 32,
                  child: Center(
                    child: FittedBox(
                      child: Icon(
                        Icons.done,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                secondChild: SizedBox.square(
                  dimension: 32,
                  child: Center(
                    child: FittedBox(
                      child: controller._steps[index].iconBuilder?.call(context) ??
                          Text(
                            '${index + 1}',
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                    ),
                  ),
                ),
                firstCurve: const Interval(0, 0.6, curve: Curves.fastOutSlowIn),
                secondCurve: const Interval(0.4, 1, curve: Curves.fastOutSlowIn),
                crossFadeState: isCompleted //
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StepperLinearIndicator extends _StepperIndicator {
  const _StepperLinearIndicator();

  @override
  Widget build(BuildContext context) {
    final controller = FineStepper.of(context);
    final options = controller.indicatorOptions;

    assert(
      () {
        for (final element in controller._steps) {
          if (element.title == null) {
            return false;
          }
        }
        return true;
      }(),
      'Step Items must have a title when using IndicatorType.linear',
    );

    final width =
        (MediaQuery.sizeOf(context).width - (2 * options.padding.left) - (2 * controller.stepCount)) /
            controller.stepCount;

    return Padding(
      padding: options.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller._activeStep.title!,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (controller._activeStep.description != null) ...[
            const SizedBox(height: 5),
            Text(
              controller._activeStep.description!,
            ),
          ],
          const SizedBox(height: 10),
          SizedBox(
            height: 4,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.stepCount,
              itemBuilder: (context, index) {
                return Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: _getStepColor(context, index),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 2),
            ),
          ),
        ],
      ),
    );
  }
}

Color _getStepColor(BuildContext context, int stepIndex) {
  final controller = FineStepper.of(context);
  final options = controller.indicatorOptions;
  final currentStepIndex = controller.stepIndex;

  final isCompleted = stepIndex < currentStepIndex;
  final isCurrent = stepIndex == currentStepIndex;

  if (isCompleted) {
    return options.completedStepColor ?? Theme.of(context).colorScheme.primary;
  }
  if (isCurrent) {
    return options.activeStepColor ?? Theme.of(context).colorScheme.primary;
  }
  return options.stepColor ?? Colors.grey[400]!;
}
