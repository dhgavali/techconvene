import 'package:flutter/material.dart';

class FormStepper extends StatefulWidget {
  final int stepCount;
  final List<Step> steps;
  final void Function() onSubmit;

  FormStepper(
      {required this.stepCount, required this.steps, required this.onSubmit});

  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  late int _currentStep;

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      currentStep: _currentStep,
      type: StepperType.horizontal,
      onStepTapped: (step) => setState(() => _currentStep = step),
      onStepContinue: () {
        if (_currentStep < widget.stepCount - 1) {
          setState(() => _currentStep += 1);
        } else {
          widget.onSubmit();
        }
      },
      onStepCancel: () {
        if (_currentStep > 0) {
          setState(() => _currentStep -= 1);
        }
      },
      steps: widget.steps,
      controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _currentStep == 0
                ? Container()
                : ElevatedButton(
                    onPressed: controlsDetails.onStepCancel,
                    child: Text('Back'),
                  ),
            ElevatedButton(
              onPressed: controlsDetails.onStepContinue,
              child: _currentStep == widget.stepCount - 1
                  ? Text('Submit')
                  : Text('Next'),
            ),
          ],
        );
      },
    );
  }
}
