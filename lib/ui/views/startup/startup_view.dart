import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/form_steps_model.dart';
import '../../../nottifiers/form model notti.dart';

class FormScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the form steps state and the notifier
    final formSteps = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final currentStep = formNotifier.currentStep;

    // Ensure there are form steps and current step is within bounds
    if (formSteps.isEmpty || currentStep >= formSteps.length) {
      return Scaffold(
        body: Center(child: Text('No steps available or invalid step index.')),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          // Main form area
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...formSteps[currentStep].formWidgets,
                ],
              ),
            ),
          ),
          // Sidebar with step titles and status, only for larger screens
          if (MediaQuery.of(context).size.width > 600)
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: formSteps.length,
                itemBuilder: (context, index) {
                  final step = formSteps[index];
                  return ListTile(
                    title: Text(step.title),
                    subtitle: Text(step.label),
                    trailing: Icon(
                      step.status == FormStatus.completed
                          ? Icons.check
                          : Icons.pending,
                      color: step.status == FormStatus.completed
                          ? Colors.green
                          : Colors.red,
                      semanticLabel: step.status == FormStatus.completed
                          ? 'Step completed'
                          : 'Step pending',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      // Bottom navigation with Save Draft and Next Step buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Save Draft Button
            ElevatedButton(
              onPressed: () {
                formNotifier.saveDraft();
              },
              child: const Text('Save Draft'),
            ),
            // Next Step Button
            ElevatedButton(
              onPressed: () {
                formNotifier.goToNextStep();
              },
              child: const Text('Next Step'),
            ),
          ],
        ),
      ),
    );
  }
}
