import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../models/form_steps_model.dart';

class FormStepsNotifier extends StateNotifier<List<FormStepsModel>> {
  FormStepsNotifier()
      : super([
          // Initial data for form steps
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

  void goToNextStep() {
    if (currentStep < state.length - 1) {
      currentStep++;
      state = [...state]; // Update state to notify listeners
    }
  }

  void saveDraft() {
    // Save draft logic
  }
}

final formProvider =
    StateNotifierProvider<FormStepsNotifier, List<FormStepsModel>>(
        (ref) => FormStepsNotifier());
