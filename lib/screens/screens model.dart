import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../nottifiers/form model notti.dart'; // Ensure the correct import path

class MultiStepForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formSteps = ref.watch(formProvider); // Watch the form steps
    final notifier = ref.read(formProvider.notifier); // Read the notifier

    // Ensure formSteps has content
    if (formSteps.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No Steps Available'),
        ),
        body: Center(
          child: Text('There are no steps in this form.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(formSteps[notifier.currentStep].title), // Display the current step's title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding for layout spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formSteps[notifier.currentStep].label, // Display the current step's label
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Add spacing between elements
            ...formSteps[notifier.currentStep].formWidgets, // Display form widgets
            SizedBox(height: 20), // Add spacing between widgets and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button only visible when not on the first step
                if (notifier.currentStep > 0)
                  ElevatedButton(
                    onPressed: () {
                      notifier.goToPreviousStep(); // Go to previous step
                    },
                    child: Text('Back'),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (notifier.currentStep < formSteps.length - 1) {
                      notifier.goToNextStep(); // Go to next step
                    } else {
                      notifier.saveDraft(); // Save draft or handle submission on the last step
                    }
                  },
                  child: Text(
                    notifier.currentStep < formSteps.length - 1 ? 'Next' : 'Submit', // Update button label based on step
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
