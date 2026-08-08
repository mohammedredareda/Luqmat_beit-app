import 'package:core/core.dart';
import 'package:flutter/material.dart';


/// "المعلومات الأساسية" — meal name + description fields, shared by
/// create/edit meal.
class MealBasicInfoSection extends StatelessWidget {
  const MealBasicInfoSection({
    super.key,
    required this.sectionTitle,
    required this.name,
    required this.nameLabel,
    required this.nameHint,
    required this.nameError,
    required this.onNameChanged,
    required this.description,
    required this.descriptionLabel,
    required this.descriptionHint,
    required this.descriptionError,
    required this.onDescriptionChanged,
  });

  final String sectionTitle;
  final String name;
  final String nameLabel;
  final String nameHint;
  final String? nameError;
  final ValueChanged<String> onNameChanged;
  final String description;
  final String descriptionLabel;
  final String descriptionHint;
  final String? descriptionError;
  final ValueChanged<String> onDescriptionChanged;

  @override
  Widget build(BuildContext context) {
    return FormSectionCard(
      title: sectionTitle,
      children: [
        TextFormField(
          initialValue: name,
          onChanged: onNameChanged,
          decoration: InputDecoration(labelText: nameLabel, hintText: nameHint, errorText: nameError),
        ),
        const SizedBox(height: AppSpace.m),
        TextFormField(
          initialValue: description,
          onChanged: onDescriptionChanged,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: descriptionLabel,
            hintText: descriptionHint,
            errorText: descriptionError,
          ),
        ),
      ],
    );
  }
}
