import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/request_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../cubit/otp/otp_cubit.dart';
import '../cubit/otp/otp_state.dart';

/// CU-01/CU-02 — OTP verification, reached right after Registration and
/// (with `purpose: OtpPurpose.passwordReset`) from Forgot Password. Matches
/// the shared `otp_verification` mockup's 4-box code entry.
class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({
    super.key,
    required this.phone,
    this.purpose = OtpPurpose.registration,
  });

  final String phone;
  final OtpPurpose purpose;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          OtpCubit(RequestOtp(getIt()), VerifyOtp(getIt()), phone: phone, purpose: purpose),
      child: _OtpView(phone: phone),
    );
  }
}

class _OtpView extends StatefulWidget {
  const _OtpView({required this.phone});

  final String phone;

  @override
  State<_OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<_OtpView> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    final code = _controllers.map((c) => c.text).join();
    context.read<OtpCubit>().codeChanged(code);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<OtpCubit, OtpState>(
      listenWhen: (previous, current) => !previous.verified && current.verified,
      listener: (context, state) async {
        final purpose = context.read<OtpCubit>().purpose;
        if (purpose == OtpPurpose.passwordReset) {
          // Verified for password recovery, not login — continue to Reset
          // Password; the reset token this call obtained is held by
          // AuthRemoteDataSource for that next request.
          if (context.mounted) context.push('/reset-password', extra: widget.phone);
          return;
        }
        // Account creation is complete — log the session in directly rather
        // than sending the user back through Login. The router's
        // `refreshListenable` picks this up and redirects into the app
        // immediately, which would clip a SnackBar shown here before it has
        // time to render — the jump straight to Home is itself the
        // confirmation, so none is shown.
        await getIt<SessionCubit>().logIn();
      },
      child: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          return AuthCardScaffold(
            title: 'رمز التحقق',
            subtitle: 'أدخل الرمز المرسل إلى ${widget.phone}',
            formChildren: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < 4; i++) ...[
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: TextField(
                          controller: _controllers[i],
                          focusNode: _focusNodes[i],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: Theme.of(context).textTheme.headlineSmall,
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.input),
                              borderSide: BorderSide(color: scheme.outline, width: 2),
                            ),
                          ),
                          onChanged: (v) => _onDigitChanged(i, v),
                        ),
                      ),
                      if (i < 3) const SizedBox(width: AppSpace.s),
                    ],
                  ],
                ),
              ),
              if (state.errorMessage != null) ...[
                const SizedBox(height: AppSpace.m),
                Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.error),
                ),
              ],
              const SizedBox(height: AppSpace.l),
              ElevatedButton(
                onPressed: state.isVerifying ? null : () => context.read<OtpCubit>().verify(),
                child: state.isVerifying
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('تأكيد'),
              ),
              const SizedBox(height: AppSpace.s),
              Center(
                child: TextButton(
                  onPressed: state.isResending
                      ? null
                      : () => context.read<OtpCubit>().resend(),
                  child: Text(
                    state.isResending ? 'جارِ إعادة الإرسال...' : 'إعادة الإرسال',
                    style: TextStyle(color: scheme.primary),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
