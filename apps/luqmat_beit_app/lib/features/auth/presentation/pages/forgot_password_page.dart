import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/request_otp.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_state.dart';

/// CU-03 — Forgot Password: request an OTP for the phone, then continue to
/// OTP verification (which then forwards to Reset Password once the code
/// is confirmed — the backend requires a verified reset token before
/// `/auth/reset-password` will accept a new password). Matches the shared
/// `forgot_password` mockup.
class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(RequestOtp(getIt())),
      child: const _ForgotPasswordView(),
    );
  }
}

class _ForgotPasswordView extends StatefulWidget {
  const _ForgotPasswordView();

  @override
  State<_ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<_ForgotPasswordView> {
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state case ForgotPasswordSent(:final phone)) {
          context.push(
            '/otp-verification',
            extra: (phone: phone, purpose: OtpPurpose.passwordReset),
          );
        }
      },
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) {
          final isSubmitting = state is ForgotPasswordSubmitting;
          final errorMessage = state is ForgotPasswordFailure ? state.exception.message : null;

          return AuthCardScaffold(
            title: 'نسيت كلمة المرور',
            subtitle: 'أدخل رقم هاتفك المسجّل وسنرسل لك رمز تحقق',
            formChildren: [
              AuthTextField(
                label: 'رقم الهاتف',
                hint: '09XXXXXXXX',
                icon: Icons.call_outlined,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                onChanged: (v) => _phone = v,
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
                    : () => context.read<ForgotPasswordCubit>().submit(_phone),
                child: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('إرسال رمز التحقق'),
              ),
            ],
          );
        },
      ),
    );
  }
}
