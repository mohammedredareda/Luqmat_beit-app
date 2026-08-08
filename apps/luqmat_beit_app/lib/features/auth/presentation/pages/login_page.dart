import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/login_customer.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/login/login_state.dart';

/// Login — no dedicated mockup exists yet (only registration/OTP/forgot
/// password are mocked up), so this screen is hand-built to match those
/// screens' visual language exactly (same `AuthCardScaffold`/`AuthTextField`
/// shell, same phone+password shape as Registration). Fully wired
/// end-to-end against the mock auth datasource — swapping in a real
/// `/auth/login` endpoint later only touches `AuthRepositoryImpl`.
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(LoginCustomer(getIt())),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  String _phone = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // The router's `refreshListenable` redirects into the app the
          // moment the session flips to authenticated.
          await getIt<SessionCubit>().logIn();
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.exception.message)),
          );
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          final isSubmitting = state is LoginSubmitting;

          return AuthCardScaffold(
            title: 'تسجيل الدخول',
            subtitle: 'أهلاً فيك من جديد بعائلة لقمة بيت',
            showBackButton: false,
            formChildren: [
              AuthTextField(
                label: 'رقم الهاتف',
                hint: '09XXXXXXXX',
                icon: Icons.call_outlined,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                onChanged: (v) => _phone = v,
              ),
              const SizedBox(height: AppSpace.m),
              _LoginPasswordField(onChanged: (v) => _password = v),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () => context.push('/forgot-password'),
                  child: Text('نسيت كلمة المرور؟',
                      style: TextStyle(color: scheme.primary)),
                ),
              ),
              const SizedBox(height: AppSpace.s),
              ElevatedButton.icon(
                onPressed: isSubmitting
                    ? null
                    : () => context
                        .read<LoginCubit>()
                        .submit(phone: _phone.trim(), password: _password),
                icon: isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.login, size: 20),
                label: const Text('تسجيل الدخول'),
              ),
              const SizedBox(height: AppSpace.s),
              Center(
                child: TextButton(
                  onPressed: () => context.pushReplacement('/register'),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.inkMutedLight, fontSize: 14),
                      children: [
                        const TextSpan(text: 'ليس لديك حساب؟ '),
                        TextSpan(
                          text: 'إنشاء حساب جديد',
                          style: TextStyle(color: scheme.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
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

class _LoginPasswordField extends StatefulWidget {
  const _LoginPasswordField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<_LoginPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('كلمة المرور', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: AppSpace.xs),
        TextField(
          obscureText: _obscure,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: 'أدخل كلمة المرور',
            prefixIcon: Icon(Icons.lock_outline, color: scheme.onSurfaceVariant),
            suffixIcon: IconButton(
              icon: Icon(_obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.input),
              borderSide: BorderSide(color: scheme.outline, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
