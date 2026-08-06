import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/detect_current_location.dart';
import '../../domain/usecases/register_customer.dart';
import '../cubit/registration/registration_cubit.dart';
import '../cubit/registration/registration_state.dart';
import '../widgets/auth_card_scaffold.dart';
import '../widgets/auth_text_field.dart';

/// CU-01 — customer registration. Matches the shared `registration`
/// mockup, with the cook-only "التسجيل كطباخة" section removed (out of
/// scope for customer_app) and the location field wired to a real device
/// GPS lookup instead of the mockup's disabled placeholder.
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationCubit(
        RegisterCustomer(getIt()),
        DetectCurrentLocation(getIt()),
      ),
      child: const _RegistrationView(),
    );
  }
}

class _RegistrationView extends StatelessWidget {
  const _RegistrationView();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return BlocListener<RegistrationCubit, RegistrationState>(
      listenWhen: (previous, current) => !previous.success && current.success,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم إنشاء الحساب! الرجاء تأكيد رقم هاتفك.')),
        );
        context.pushReplacement('/otp-verification', extra: state.phone);
      },
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (context, state) {
          final cubit = context.read<RegistrationCubit>();

          return AuthCardScaffold(
            title: 'إنشاء حساب جديد',
            subtitle: 'انضم إلى عائلة لقمة بيت واستمتع بأشهى المأكولات',
            formChildren: [
              AuthTextField(
                label: 'الاسم الكامل',
                hint: 'أدخل اسمك الثلاثي',
                icon: Icons.person_outline,
                onChanged: cubit.fullNameChanged,
              ),
              const SizedBox(height: AppSpace.m),
              AuthTextField(
                label: 'رقم الهاتف',
                hint: '09XXXXXXXX',
                icon: Icons.call_outlined,
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr,
                onChanged: cubit.phoneChanged,
              ),
              const SizedBox(height: AppSpace.m),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الموقع الجغرافي', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: AppSpace.xs),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          readOnly: true,
                          controller: TextEditingController(
                            text: state.detectedLocation?.formattedAddress ?? '',
                          ),
                          decoration: InputDecoration(
                            hintText: 'سيتم تحديد الموقع تلقائياً',
                            prefixIcon: Icon(Icons.location_on_outlined,
                                color: scheme.onSurfaceVariant),
                            filled: true,
                            fillColor: scheme.surfaceContainerLowest,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(AppRadius.input),
                              borderSide: BorderSide(color: scheme.outline, width: 2),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpace.s),
                      SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: state.isDetectingLocation ? null : cubit.detectLocation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.zaatarContainer,
                            foregroundColor: AppColors.onZaatarContainer,
                            elevation: 0,
                          ),
                          icon: state.isDetectingLocation
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : const Icon(Icons.my_location, size: 20),
                          label: const Text('تحديد'),
                        ),
                      ),
                    ],
                  ),
                  if (state.locationError != null) ...[
                    const SizedBox(height: AppSpace.xs),
                    Text(
                      state.locationError!,
                      style: TextStyle(color: scheme.error, fontSize: 12),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpace.m),
              AuthTextField(
                label: 'العنوان التفصيلي',
                hint: 'المدينة، الحي، الشارع، رقم البناية...',
                icon: Icons.home_outlined,
                maxLines: 2,
                onChanged: cubit.addressChanged,
              ),
              const SizedBox(height: AppSpace.m),
              _PasswordField(onChanged: cubit.passwordChanged),
              if (state.submitError != null) ...[
                const SizedBox(height: AppSpace.m),
                Text(
                  state.submitError!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: scheme.error),
                ),
              ],
              const SizedBox(height: AppSpace.l),
              ElevatedButton.icon(
                onPressed: state.isSubmitting ? null : cubit.submit,
                icon: state.isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.person_add_alt_1, size: 20),
                label: const Text('إنشاء الحساب'),
              ),
              const SizedBox(height: AppSpace.s),
              Center(
                child: TextButton(
                  onPressed: () => context.pushReplacement('/login'),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.inkMutedLight, fontSize: 14),
                      children: [
                        const TextSpan(text: 'لديك حساب بالفعل؟ '),
                        TextSpan(
                          text: 'تسجيل الدخول',
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

class _PasswordField extends StatefulWidget {
  const _PasswordField({required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
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
            hintText: 'أدخل كلمة مرور قوية',
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
