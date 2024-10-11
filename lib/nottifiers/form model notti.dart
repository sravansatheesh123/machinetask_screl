import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/form_steps_model.dart';

class FormStepsNotifier extends StateNotifier<List<FormStepsModel>> {
  FormStepsNotifier()
      : super([
    FormStepsModel(
      title: 'Step 1',
      label: 'Basic Information',
      status: FormStatus.pending,
      formWidgets: [Text('Name'), TextField()],
    ),
    FormStepsModel(
      title: 'Step 2',
      label: 'Additional Information',
      status: FormStatus.pending,
      formWidgets: [Text('Address'), TextField()],
    ),
  ]);

  int currentStep = 0;

  // Proceed to next step
  void goToNextStep() {
    if (currentStep < state.length - 1) {
      currentStep++;
      state = [...state]; // Notify listeners of the state change
    }
  }

  // Go back to previous step
  void goToPreviousStep() {
    if (currentStep > 0) {
      currentStep--;
      state = [...state]; // Notify listeners of the state change
    }
  }

  // Save draft logic
  void saveDraft() {
    // Implement your draft-saving logic here
  }

  // Get current form step model
  FormStepsModel get currentStepModel => state[currentStep];
}

// Create the provider for form steps
final formProvider =
StateNotifierProvider<FormStepsNotifier, List<FormStepsModel>>(
      (ref) => FormStepsNotifier(),
);
