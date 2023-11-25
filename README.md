# Fine Stepper

### A horizontal stepper that does the job just fine by offering easy to use apis to control the stepper from any where down the widget tree

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]




## Icon Stepper

Create an Icon Stepper by using `FineStepper.icon` constructor, with list of `StepItem.icon`s.

```dart
FineStepper.icon(
  steps: [
    StepItem.icon(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    ),
    StepItem.icon(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    ),
    StepItem.icon(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    )
  ],
),
```

## Linear Stepper

Similarly, for creating a Linear Stepper, Use the `FineStepper.linear` constructor, with list of `StepItem.linear`s. 

```dart
FineStepper.linear(
  steps: [
    StepItem.linear(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    ),
    StepItem.linear(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    ),
    StepItem.linear(
      builder: (context) => StepBuilder(
        child: Text('Step ${FineStepper.of(context).stepIndex}'),
      ),
    )
  ],
),
```


## StepBuilder
`StepBuilder` provides controls for navigating through steps with two layout options for the controls: 

### `StepLayout.stack` (default)

which gives the child the available height, and adds the controls on top of the it, aligned to bottom center.


<img width="342" alt="step_builder_stack" src="https://github.com/michaelsoliman1/fine_stepper/assets/40867495/8988df4e-f9b9-4733-91a6-72d5ee6b4666">

#### Example
```dart
StepBuilder(
  child: SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${FineStepper.of(context).stepIndex + 1}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'StepLayout: Stack',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  ),
);
```

### `StepLayout.column`

which gives the child the minium height it needs, and adds the controls after it

<img width="342" alt="step_builder_column" src="https://github.com/michaelsoliman1/fine_stepper/assets/40867495/cac45f51-dc63-474e-b897-cd711e5ee1fc">

#### Example
```dart
StepBuilder(
  layout: StepLayout.column,
  child: SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${FineStepper.of(context).stepIndex + 1}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'StepLayout: Column',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    ),
  ),
);
```

### FormStepBuilder

Same as `StepBuilder`, but validates any field inside the child widget before moving forward

```dart
FormStepBuilder(
  child: TextFormField(
    decoration: const InputDecoration(hintText: 'Example'),
    // validator is executed on `FineStepper.of(context).stepForward`
    validator: (value) => (value?.isEmpty ?? true) ? 'Required Field' : null,
  ),
),  
```

### StepperController
Controller to access and control the state of the stepper with `FineStepper.of(context)` 

available apis:
```dart
/// Current Step Index
int get stepIndex;

/// Update current step Index
set stepIndex(int index);

/// Check if this is the first step
bool get isFirstStep;

/// Check if this is the last step
bool get isLastStep;

/// Check if the stepper is finishing
/// i.e it the last step and finish is pressed
bool get finishing;

/// Make a step back
///
/// if [isFirstStep] is true, then it will do nothing
void stepBack();

/// Make a step forward
///
/// if [isLastStep] is true, then it will update [finishing] flag to be true
/// and call [onFinish], if passed.
///
/// if [finishing] is true, it will do nothing
Future<void> stepForward();
```

### IndicatorOptions
You can change steps indicators colors by passing `IndicatorOptions` object to `FineStepper`.

available options:

```dart
/// Step Color when active, default to [ColorScheme.primary]
final Color? activeStepColor;

/// Step Color when completed, default to [ColorScheme.primary]
final Color? completedStepColor;

/// default Step Color, default to [Colors.grey[400]]
final Color? stepColor;

/// Indicator paddings
final EdgeInsets padding;

/// whether the indicator scrolls or not
///
/// has no effect when using FineStepper.linear
final bool scrollable;

```




Generated by [Very Good CLI][very_good_cli_link] 🤖


[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
