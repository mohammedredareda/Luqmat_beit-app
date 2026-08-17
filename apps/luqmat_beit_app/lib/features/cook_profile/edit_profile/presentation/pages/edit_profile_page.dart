import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../presentation/weekday_label.dart';
import '../bloc/edit_profile_bloc.dart';
import '../bloc/edit_profile_event.dart';
import '../bloc/edit_profile_state.dart';
import '../bloc/profile_submit_status.dart';
import '../widgets/availability_editor.dart';
import '../widgets/edit_profile_skeleton.dart';
import '../widgets/profile_avatar_picker.dart';

/// CK-20 Edit Profile. No bottom nav — a task-focused sub-screen reached
/// from the Profile tab (R-03).
class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EditProfileBloc>()..add(const EditProfileEvent.started()),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
    final tokens = fieldErrors[field];
    if (tokens == null || tokens.isEmpty) return null;
    return switch (tokens.first) {
      'required' => l10n.validationRequiredField,
      'imageTooLarge' => l10n.validationImageTooLarge,
      'invalidRange' => l10n.validationInvalidAvailabilityRange,
      _ => l10n.genericErrorMessage,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileForm) {
          state.data.submitStatus.whenOrNull(
            success: (_) => Navigator.of(context).pop(true),
            failure: (exception) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(exception.message)),
              );
            },
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.editProfileTitle)),
        body: BlocBuilder<EditProfileBloc, EditProfileState>(
          builder: (context, state) => state.when(
            loading: () => const EditProfileSkeleton(),
            loadError: (exception) => _LoadErrorBody(message: exception.message),
            form: (data) => _FormBody(
              data: data,
              fieldError: (field) => _fieldError(
                l10n,
                data.submitStatus.maybeWhen(
                  validationFailure: (errors) => errors,
                  orElse: () => const <String, List<String>>{},
                ),
                field,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadErrorBody extends StatelessWidget {
  const _LoadErrorBody({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: scheme.error),
            const SizedBox(height: AppSpace.m),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpace.l),
            OutlinedButton(
              onPressed: () =>
                  context.read<EditProfileBloc>().add(const EditProfileEvent.retryLoadPressed()),
              child: Text(l10n.retryLabel),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.data, required this.fieldError});

  final EditProfileFormData data;
  final String? Function(String field) fieldError;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<EditProfileBloc>();
    final isSubmitting = data.submitStatus is ProfileSubmitSubmitting;

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        ProfileAvatarPicker(
          avatarPath: data.avatarPath,
          onImagePicked: (path, sizeBytes) =>
              bloc.add(EditProfileEvent.avatarPicked(path, sizeBytes)),
          errorText: fieldError('avatar'),
        ),
        const SizedBox(height: AppSpace.xl),
        TextFormField(
          initialValue: data.fullName,
          onChanged: (value) => bloc.add(EditProfileEvent.fullNameChanged(value)),
          decoration: InputDecoration(
            labelText: l10n.fullNameLabel,
            hintText: l10n.fullNameHint,
            errorText: fieldError('fullName'),
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(height: AppSpace.l),
        TextFormField(
          initialValue: data.bio,
          onChanged: (value) => bloc.add(EditProfileEvent.bioChanged(value)),
          maxLines: 4,
          decoration: InputDecoration(
            labelText: l10n.bioLabel,
            hintText: l10n.bioHint,
            alignLabelWithHint: true,
            prefixIcon: const Icon(Icons.description_outlined),
          ),
        ),
        const SizedBox(height: AppSpace.l),
        TextFormField(
          initialValue: data.address,
          onChanged: (value) => bloc.add(EditProfileEvent.addressChanged(value)),
          maxLines: 3,
          decoration: InputDecoration(
            labelText: l10n.addressLabel,
            hintText: l10n.addressHint,
            errorText: fieldError('address'),
            alignLabelWithHint: true,
            prefixIcon: const Icon(Icons.location_on_outlined),
          ),
        ),
        const SizedBox(height: AppSpace.s),
        _LocationDetector(data: data),
        const SizedBox(height: AppSpace.l),
        _AvailabilityDaysPicker(
          selectedDays: data.selectedDays,
          onDayToggled: (value) => bloc.add(EditProfileEvent.availabilityDayToggled(value)),
        ),
        const SizedBox(height: AppSpace.l),
        AvailabilityEditor(
          startTime: data.availabilityStartTime,
          endTime: data.availabilityEndTime,
          onStartTimeChanged: (value) =>
              bloc.add(EditProfileEvent.availabilityStartTimeChanged(value)),
          onEndTimeChanged: (value) => bloc.add(EditProfileEvent.availabilityEndTimeChanged(value)),
          hoursErrorText: fieldError('availabilityHours'),
        ),
        const SizedBox(height: AppSpace.xl),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: isSubmitting ? null : () => bloc.add(const EditProfileEvent.submitPressed()),
            icon: isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(l10n.saveProfileChangesCta),
          ),
        ),
        const SizedBox(height: AppSpace.m),
        SizedBox(
          height: 48,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancelLabel),
          ),
        ),
      ],
    );
  }
}

/// A per-day toggle-chip row (any combination, not a contiguous range) —
/// the cook picks exactly which individual weekdays they're open.
class _AvailabilityDaysPicker extends StatelessWidget {
  const _AvailabilityDaysPicker({required this.selectedDays, required this.onDayToggled});

  final Set<Weekday> selectedDays;
  final ValueChanged<Weekday> onDayToggled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.availabilityDaysFieldLabel, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpace.s),
        Wrap(
          spacing: AppSpace.s,
          runSpacing: AppSpace.s,
          children: [
            for (final day in Weekday.values)
              FilterChip(
                label: Text(weekdayLabel(l10n, day)),
                selected: selectedDays.contains(day),
                onSelected: (_) => onDayToggled(day),
                selectedColor: scheme.primaryContainer,
                checkmarkColor: scheme.onPrimaryContainer,
              ),
          ],
        ),
      ],
    );
  }
}

/// Mirrors the registration screen's location-detect block (read-only
/// field + "تحديد" button) — never overwrites the independently-editable
/// address field above it, unlike registration.
class _LocationDetector extends StatelessWidget {
  const _LocationDetector({required this.data});

  final EditProfileFormData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bloc = context.read<EditProfileBloc>();

    final coordsText = data.latitude != null && data.longitude != null
        ? '${data.latitude!.toStringAsFixed(5)}, ${data.longitude!.toStringAsFixed(5)}'
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                controller: TextEditingController(text: coordsText),
                decoration: InputDecoration(
                  hintText: l10n.detectedLocationHint,
                  prefixIcon: Icon(Icons.my_location, color: scheme.onSurfaceVariant),
                ),
              ),
            ),
            const SizedBox(width: AppSpace.s),
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: data.isDetectingLocation
                    ? null
                    : () => bloc.add(const EditProfileEvent.detectLocationPressed()),
                icon: data.isDetectingLocation
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.my_location, size: 20),
                label: Text(l10n.detectLocationCta),
              ),
            ),
          ],
        ),
        if (data.locationError != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(
            data.locationError!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: scheme.error),
          ),
        ],
      ],
    );
  }
}
