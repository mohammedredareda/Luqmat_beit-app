import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:luqmat_beit_app/di/injection.dart';
import 'package:luqmat_beit_app/l10n/generated/app_localizations.dart';

import '../../domain/phone_number_validator.dart';
import '../bloc/change_phone_number_bloc.dart';
import '../bloc/change_phone_number_event.dart';
import '../bloc/change_phone_number_state.dart';

/// Net-new (no backlog story) — reached only from Settings, per the
/// decision to remove phone-number editing from Edit Profile entirely.
/// Single route whose body swaps between the phone-input step and the
/// (reused `otp_verification` mockup) OTP-entry step, so both steps share
/// one [ChangePhoneNumberBloc] instance without splitting across routes.
class ChangePhoneNumberPage extends StatelessWidget {
  const ChangePhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChangePhoneNumberBloc>(),
      child: const _ChangePhoneNumberView(),
    );
  }
}

class _ChangePhoneNumberView extends StatelessWidget {
  const _ChangePhoneNumberView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ChangePhoneNumberBloc, ChangePhoneNumberState>(
      listener: (context, state) {
        state.whenOrNull(success: (phoneNumber) => Navigator.of(context).pop(phoneNumber));
      },
      child: Scaffold(
        appBar: AppBar(
          leading: BlocBuilder<ChangePhoneNumberBloc, ChangePhoneNumberState>(
            buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
            builder: (context, state) => IconButton(
              icon: const BackButtonIcon(),
              onPressed: () {
                if (state is ChangePhoneNumberEnteringOtp) {
                  context
                      .read<ChangePhoneNumberBloc>()
                      .add(const ChangePhoneNumberEvent.backToPhoneInputPressed());
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          title: BlocBuilder<ChangePhoneNumberBloc, ChangePhoneNumberState>(
            buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
            builder: (context, state) => Text(
              state is ChangePhoneNumberEnteringOtp
                  ? l10n.otpVerificationTitle
                  : l10n.changePhoneNumberTitle,
            ),
          ),
        ),
        body: BlocBuilder<ChangePhoneNumberBloc, ChangePhoneNumberState>(
          builder: (context, state) => state.map(
            enteringPhone: (s) => _PhoneInputView(state: s),
            enteringOtp: (s) => _OtpVerificationView(state: s),
            success: (s) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final capped = digits.length > 9 ? digits.substring(0, 9) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < capped.length; i++) {
      if (i == 3 || i == 6) buffer.write(' ');
      buffer.write(capped[i]);
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class _PhoneInputView extends StatefulWidget {
  const _PhoneInputView({required this.state});

  final ChangePhoneNumberEnteringPhone state;

  @override
  State<_PhoneInputView> createState() => _PhoneInputViewState();
}

class _PhoneInputViewState extends State<_PhoneInputView> {
  late final TextEditingController _controller =
      TextEditingController(text: widget.state.phoneNumber);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _errorText(AppLocalizations l10n) => switch (widget.state.errorMessage) {
        null => null,
        'invalidPhoneNumber' => l10n.phoneNumberInvalidError,
        final message => message,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bloc = context.read<ChangePhoneNumberBloc>();

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.l, AppSpace.l, AppSpace.xxl),
      children: [
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: scheme.primaryContainer, shape: BoxShape.circle),
            child: Icon(Icons.smartphone, size: 28, color: scheme.primary),
          ),
        ),
        const SizedBox(height: AppSpace.l),
        Text(
          l10n.changePhoneNumberHeading,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSpace.s),
        Text(
          l10n.changePhoneNumberDescription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.xl),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.phone,
          textDirection: TextDirection.ltr,
          inputFormatters: [_PhoneNumberInputFormatter()],
          onChanged: (value) => bloc.add(
            ChangePhoneNumberEvent.phoneNumberChanged(value.replaceAll(RegExp(r'\D'), '')),
          ),
          decoration: InputDecoration(
            labelText: l10n.newPhoneNumberLabel,
            hintText: '9XX XXX XXX',
            errorText: _errorText(l10n),
            prefixIcon: const Padding(
              padding: EdgeInsetsDirectional.only(start: AppSpace.m),
              child: Align(widthFactor: 1, alignment: Alignment.centerLeft, child: Text('+963')),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.s),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 16, color: scheme.onSurfaceVariant),
            const SizedBox(width: AppSpace.xs),
            Expanded(
              child: Text(
                l10n.newPhoneNumberHelper,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        SizedBox(
          height: 48,
          child: ElevatedButton.icon(
            onPressed: widget.state.isSubmitting || widget.state.phoneNumber.length != 9
                ? null
                : () => bloc.add(const ChangePhoneNumberEvent.sendCodeSubmitted()),
            icon: widget.state.isSubmitting
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.arrow_forward),
            label: Text(l10n.sendVerificationCodeCta),
          ),
        ),
      ],
    );
  }
}

class _OtpVerificationView extends StatefulWidget {
  const _OtpVerificationView({required this.state});

  final ChangePhoneNumberEnteringOtp state;

  @override
  State<_OtpVerificationView> createState() => _OtpVerificationViewState();
}

class _OtpVerificationViewState extends State<_OtpVerificationView> {
  static const _otpLength = 4;
  static const _resendSeconds = 59;

  final _controllers = List.generate(_otpLength, (_) => TextEditingController());
  final _focusNodes = List.generate(_otpLength, (_) => FocusNode());
  Timer? _timer;
  int _secondsLeft = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _resendSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    final combined = _controllers.map((c) => c.text).join();
    context.read<ChangePhoneNumberBloc>().add(ChangePhoneNumberEvent.otpChanged(combined));
  }

  String? _errorText(AppLocalizations l10n) => switch (widget.state.errorMessage) {
        null => null,
        'incorrect' => l10n.otpIncorrectError,
        final message => message,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final bloc = context.read<ChangePhoneNumberBloc>();
    final canResend = _secondsLeft == 0 && !widget.state.isResending;
    final errorText = _errorText(l10n);

    return ListView(
      padding: const EdgeInsets.fromLTRB(AppSpace.l, AppSpace.xxl, AppSpace.l, AppSpace.xxl),
      children: [
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: scheme.surfaceContainerHighest, shape: BoxShape.circle),
            child: Icon(Icons.chat_bubble_outline, size: 28, color: scheme.primary),
          ),
        ),
        const SizedBox(height: AppSpace.l),
        Text(
          l10n.otpSentHeading,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpace.s),
        Text(
          l10n.otpSentDescription,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          formatLocalPhoneNumber(widget.state.phoneNumber),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpace.xl),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _otpLength,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.xs),
                child: SizedBox(
                  width: 56,
                  height: 64,
                  child: TextField(
                    controller: _controllers[index],
                    focusNode: _focusNodes[index],
                    autofocus: index == 0,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: Theme.of(context).textTheme.headlineSmall,
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (value) => _onDigitChanged(index, value),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: AppSpace.s),
          Text(errorText, textAlign: TextAlign.center, style: TextStyle(color: scheme.error)),
        ],
        const SizedBox(height: AppSpace.xl),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(l10n.resendCodePrompt, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: AppSpace.xs),
            if (canResend)
              TextButton(
                onPressed: () {
                  bloc.add(const ChangePhoneNumberEvent.resendPressed());
                  _startTimer();
                },
                child: Text(l10n.resendCodeCta),
              )
            else
              Text(
                '00:${_secondsLeft.toString().padLeft(2, '0')}',
                textDirection: TextDirection.ltr,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
          ],
        ),
        const SizedBox(height: AppSpace.xl),
        SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: widget.state.isVerifying || widget.state.otp.length != _otpLength
                ? null
                : () => bloc.add(const ChangePhoneNumberEvent.verifySubmitted()),
            child: widget.state.isVerifying
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(l10n.verifyCta),
          ),
        ),
      ],
    );
  }
}
