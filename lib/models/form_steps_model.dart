// lib/models/form_steps_model.dart
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_steps_model.freezed.dart';
part 'form_steps_model.g.dart';

enum FormStatus { pending, completed, initial }

@freezed
class FormStepsModel with _$FormStepsModel {
  const factory FormStepsModel({
    required String title,
    required String label,
    required FormStatus status,
    required List<Widget> formWidgets, // Changed to List<Widget>
  }) = _FormStepsModel;

  factory FormStepsModel.fromJson(Map<String, dynamic> json) =>
      _$FormStepsModelFromJson(json);
}
