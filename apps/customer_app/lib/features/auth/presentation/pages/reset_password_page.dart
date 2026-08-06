import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/reset_password.dart';
import '../cubit/reset_password/reset_password_cubit.dart';
import '../cubit/reset_password/reset_password_state.dart';
import '../widgets/auth_card_scaffold.dart';

/// CU-03 — set a new password after OTP verification from Forgot Password.
/// Matches the shared `reset_password` mockup.
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key, required this.phone});

  final String phone;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(ResetPassword(getIt())),
      child: _ResetPasswordView(phone: phone),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  const _ResetPasswordView({required this.phone});

  final String phone;

  @override
  State<_ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<_ResetPasswordView> {
  String _password = '';
  String _confirmPassword = '';
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تحديث كلمة المرور، يمكنك تسجيل الدخول الآن.')),
          );
          context.go('/login');
        }
      },
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
        builder: (context, state) {
          final isSubmitting = state is ResetPasswordSubmitting;
          final errorMessage = state is ResetPasswordFailure ? state.exception.message : null;

          return AuthCardScaffold(
            title: 'كلمة مرور جديدة',
            subtitle: 'أدخل كلمة مرور جديدة لحسابك',
            formChildren: [
              TextField(
                obscureText: _obscure,
                onChanged: (v) => _password = v,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور الجديدة',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.m),
              TextField(
                obscureText: _obscure,
                onChanged: (v) => _confirmPassword = v,
                decoration: InputDecoration(
                  labelText: 'تأكيد كلمة المرور',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.input),
                  ),
                ),
              ),
              if (errorMessage != null) ...[
                const SizedBox(height: AppSpace.m),
                Text(errorMessage, textAlign: TextAlign.center,
                    style: TextStyle(color: scheme.error)),
              ],
              const SizedBox(height: AppSpace.l),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () {
                        if (_password != _confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('كلمتا المرور غير متطابقتين.')),
                          );
                          return;
                        }
                        context
                            .read<ResetPasswordCubit>()
                            .submit(phone: widget.phone, newPassword: _password);
                      },
                child: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('تحديث كلمة المرور'),
              ),
            ],
          );
        },
      ),
    );
  }
}
