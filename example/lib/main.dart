import 'package:fine_stepper/fine_stepper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: FineStepper(
          steps: [
            StepItem(
              builder: (context) => StepBuilder(
                child: Text('Step ${FineStepper.of(context).stepIndex}'),
              ),
            ),
            StepItem(
              builder: (context) => StepBuilder(
                child: Text('Step ${FineStepper.of(context).stepIndex}'),
              ),
            ),
            StepItem(
              builder: (context) => StepBuilder(
                child: Text('Step ${FineStepper.of(context).stepIndex}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
