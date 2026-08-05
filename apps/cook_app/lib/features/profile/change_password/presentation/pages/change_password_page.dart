import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cook_app/di/injection.dart';
import 'package:cook_app/l10n/generated/app_localizations.dart';

import '../../domain/password_validator.dart';
import '../bloc/change_password_cubit.dart';
import '../bloc/change_password_state.dart';
import '../widgets/password_strength_meter.dart';

/// CK-27 Change Password — reached from Settings, not Edit Profile. No
/// bottom nav — a task-focused sub-screen (R-03).
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePasswordCubit>(),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  void initState() {
    super.initState();
    for (final controller in [_currentController, _newController, _confirmController]) {
      controller.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _currentController.text.isNotEmpty &&
      validateNewPassword(_newController.text).isEmpty &&
      _confirmController.text == _newController.text;

  String? _fieldError(AppLocalizations l10n, Map<String, List<String>> fieldErrors, String field) {
    final tokens = fieldErrors[field];
    if (tokens == null || tokens.isEmpty) return null;
    return switch (tokens.first) {
      'required' => l10n.validationRequiredField,
      'incorrect' => l10n.currentPasswordIncorrectError,
      'mismatch' => l10n.passwordMismatchError,
      _ => l10n.passwordComplexityError,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        state.whenOrNull(
          success: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(l10n.passwordUpdatedSuccessMessage)));
            Navigator.of(context).pop();
          },
          failure: (exception) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(exception.message)));
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.changePasswordTitle)),
        body: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
          builder: (context, state) {
            final isSubmitting = state is ChangePasswordSubmitting;
            final fieldErrors =
                state is ChangePasswordFieldErrors ? state.fieldErrors : const <String, List<String>>{};

            return ListView(
              padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
              children: [
                Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.lock_reset, size: 40, color: scheme.primary),
                  ),
                ),
                const SizedBox(height: AppSpace.l),
                Text(
                  l10n.changePasswordHeading,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpace.s),
                Text(
                  l10n.changePasswordDescription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: AppSpace.xl),
                TextFormField(
                  controller: _currentController,
                  obscureText: !_showCurrent,
                  decoration: InputDecoration(
                    labelText: l10n.currentPasswordLabel,
                    errorText: _fieldError(l10n, fieldErrors, 'currentPassword'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_showCurrent ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _showCurrent = !_showCurrent),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.l),
                TextFormField(
                  controller: _newController,
                  obscureText: !_showNew,
                  decoration: InputDecoration(
                    labelText: l10n.newPasswordLabel,
                    errorText: _fieldError(l10n, fieldErrors, 'newPassword'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_showNew ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _showNew = !_showNew),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.s),
                PasswordStrengthMeter(password: _newController.text),
                const SizedBox(height: AppSpace.l),
                TextFormField(
                  controller: _confirmController,
                  obscureText: !_showConfirm,
                  decoration: InputDecoration(
                    labelText: l10n.confirmNewPasswordLabel,
                    errorText: _confirmController.text.isNotEmpty &&
                            _confirmController.text != _newController.text
                        ? l10n.passwordMismatchError
                        : _fieldError(l10n, fieldErrors, 'confirmPassword'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_showConfirm ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _showConfirm = !_showConfirm),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.xl),
                SizedBox(
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: isSubmitting || !_canSubmit
                        ? null
                        : () => context.read<ChangePasswordCubit>().submit(
                              currentPassword: _currentController.text,
                              newPassword: _newController.text,
                              confirmPassword: _confirmController.text,
                            ),
                    icon: isSubmitting
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.check_circle_outline),
                    label: Text(l10n.updatePasswordCta),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
