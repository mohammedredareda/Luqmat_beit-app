import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../../../offers_management/shared/presentation/widgets/select_meal_popup.dart';
import '../../../shared/domain/short_form_validator.dart';
import '../../../shared/presentation/bloc/short_submit_status.dart';
import '../bloc/create_short_bloc.dart';
import '../bloc/create_short_event.dart';
import '../bloc/create_short_state.dart';

/// Cook-side Create Short — mockup `_3`.
class CreateShortPage extends StatelessWidget {
  const CreateShortPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CreateShortBloc>(),
      child: const _CreateShortView(),
    );
  }
}

String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
  final tokens = fieldErrors[field];
  if (tokens == null || tokens.isEmpty) return null;
  return switch (tokens.first) {
    'required' when field == 'video' => l10n.validationVideoRequired,
    'required' => l10n.validationRequiredField,
    'tooLong' => l10n.validationDescriptionTooLong,
    _ => l10n.genericErrorMessage,
  };
}

class _CreateShortView extends StatelessWidget {
  const _CreateShortView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<CreateShortBloc, CreateShortState>(
      listener: (context, state) {
        state.submitStatus.whenOrNull(
          success: (_) => Navigator.of(context).pop(true),
          failure: (exception) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(exception.message)),
            );
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.createShortTitle)),
        body: BlocBuilder<CreateShortBloc, CreateShortState>(
          builder: (context, state) => _FormBody(state: state),
        ),
      ),
    );
  }
}

class _FormBody extends StatelessWidget {
  const _FormBody({required this.state});

  final CreateShortState state;

  Future<void> _pickVideo(BuildContext context) async {
    final picked = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: shortMaxVideoDuration,
    );
    if (picked == null || !context.mounted) return;
    final sizeBytes = await picked.length();
    if (!context.mounted) return;
    context.read<CreateShortBloc>().add(CreateShortEvent.videoPicked(picked.path, sizeBytes));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bloc = context.read<CreateShortBloc>();
    final isSubmitting = state.submitStatus is ShortSubmitSubmitting;
    final fieldErrors = state.submitStatus.maybeWhen(
      validationFailure: (errors) => errors,
      orElse: () => const <String, List<String>>{},
    );
    final videoError = _fieldError(l10n, fieldErrors, 'video');
    final hasVideo = state.videoPath != null && state.videoPath!.isNotEmpty;

    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpace.l),
      children: [
        InkWell(
          onTap: () => _pickVideo(context),
          borderRadius: BorderRadius.circular(AppRadius.image),
          child: Container(
            constraints: const BoxConstraints(minHeight: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.image),
              color: scheme.surfaceContainerHighest,
              border: hasVideo
                  ? null
                  : Border.all(
                      color: videoError != null ? scheme.error : scheme.outline,
                      width: 1.5,
                    ),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    hasVideo ? Icons.videocam : Icons.video_library_outlined,
                    size: 40,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: AppSpace.s),
                  Text(
                    hasVideo ? l10n.videoSelectedLabel : l10n.videoPickerHint,
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: AppSpace.xs),
                  Text(
                    l10n.videoMaxDurationHint,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (videoError != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(videoError, style: textTheme.bodySmall?.copyWith(color: scheme.error)),
        ],
        const SizedBox(height: AppSpace.xl),
        Text(l10n.shortDescriptionLabel, style: textTheme.titleMedium),
        const SizedBox(height: AppSpace.s),
        TextFormField(
          initialValue: state.description,
          onChanged: (value) => bloc.add(CreateShortEvent.descriptionChanged(value)),
          maxLines: 4,
          maxLength: maxShortDescriptionLength,
          decoration: InputDecoration(
            hintText: l10n.shortDescriptionHint,
            errorText: _fieldError(l10n, fieldErrors, 'description'),
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        Divider(color: scheme.outlineVariant),
        const SizedBox(height: AppSpace.xl),
        Text(l10n.linkedMealSectionTitle, style: textTheme.titleMedium),
        const SizedBox(height: AppSpace.s),
        Text(
          l10n.linkedMealOptionalHint,
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.m),
        if (state.selectedMeal == null)
          InkWell(
            borderRadius: BorderRadius.circular(AppRadius.input),
            onTap: () async {
              final meal = await showSelectMealPopup(context, excludedMealIds: const {});
              if (meal != null && context.mounted) {
                bloc.add(CreateShortEvent.mealSelected(meal));
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                hintText: l10n.chooseMealCta,
                suffixIcon: const Icon(Icons.expand_more),
              ),
              child: Text(l10n.chooseMealCta, style: textTheme.bodyMedium),
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(AppSpace.m),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.card),
              border: Border.all(color: scheme.outline),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.image),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: SizedBox(
                      width: 64,
                      child: Image.network(state.selectedMeal!.imageUrl, fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpace.m),
                Expanded(
                  child: Text(
                    state.selectedMeal!.name,
                    style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => bloc.add(const CreateShortEvent.mealRemoved()),
                  icon: Icon(Icons.close, color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSpace.xl),
        ElevatedButton.icon(
          onPressed: isSubmitting ? null : () => bloc.add(const CreateShortEvent.submitPressed()),
          icon: isSubmitting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.publish),
          label: Text(l10n.publishShortCta),
        ),
      ],
    );
  }
}
