import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../di/injection.dart';
import '../../domain/usecases/register.dart';
import '../cubit/registration/registration_cubit.dart';
import '../cubit/registration/registration_state.dart';

/// CU-01/CK-01 — one shared registration form for both roles, matching the
/// shared mockup: the base form is identical to the customer flow, with a
/// "التسجيل كطباخة" checkbox that expands a conditional group for the
/// cook-only fields (availability, description) rather than routing to a
/// separate screen per role — there's no other way to pick a role, since
/// which app you'd opened used to be the signal and that's gone now.
class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationCubit(
        Register(getIt()),
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
              const SizedBox(height: AppSpace.m),
              const Divider(),
              const SizedBox(height: AppSpace.xs),
              _RegisterAsCookToggle(
                value: state.registerAsCook,
                onChanged: cubit.registerAsCookChanged,
              ),
              if (state.registerAsCook) ...[
                const SizedBox(height: AppSpace.m),
                Container(
                  padding: const EdgeInsets.all(AppSpace.m),
                  decoration: BoxDecoration(
                    color: scheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(AppRadius.input),
                    border: Border.all(color: scheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('أوقات التوفر', style: Theme.of(context).textTheme.labelLarge),
                      const SizedBox(height: AppSpace.xs),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<Weekday>(
                              initialValue: state.startDay,
                              decoration: InputDecoration(
                                labelText: 'من يوم',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.input),
                                  borderSide: BorderSide(color: scheme.outline, width: 2),
                                ),
                              ),
                              items: [
                                for (final day in Weekday.values)
                                  DropdownMenuItem(value: day, child: Text(day.arabicLabel)),
                              ],
                              onChanged: (value) {
                                if (value != null) cubit.startDayChanged(value);
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpace.s),
                          Expanded(
                            child: DropdownButtonFormField<Weekday>(
                              initialValue: state.endDay,
                              decoration: InputDecoration(
                                labelText: 'إلى يوم',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(AppRadius.input),
                                  borderSide: BorderSide(color: scheme.outline, width: 2),
                                ),
                              ),
                              items: [
                                for (final day in Weekday.values)
                                  DropdownMenuItem(value: day, child: Text(day.arabicLabel)),
                              ],
                              onChanged: (value) {
                                if (value != null) cubit.endDayChanged(value);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpace.s),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: state.startTime,
                                );
                                if (picked != null) cubit.startTimeChanged(picked);
                              },
                              icon: const Icon(Icons.schedule, size: 18),
                              label: Text('من: ${state.startTime.format(context)}'),
                            ),
                          ),
                          const SizedBox(width: AppSpace.s),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                final picked = await showTimePicker(
                                  context: context,
                                  initialTime: state.endTime,
                                );
                                if (picked != null) cubit.endTimeChanged(picked);
                              },
                              icon: const Icon(Icons.schedule, size: 18),
                              label: Text('إلى: ${state.endTime.format(context)}'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpace.m),
                      AuthTextField(
                        label: 'نبذة قصيرة',
                        hint: 'اذكر خبرتك وأشهر أطباقك باختصار',
                        icon: Icons.edit_note_outlined,
                        maxLines: 2,
                        onChanged: cubit.descriptionChanged,
                      ),
                    ],
                  ),
                ),
              ],
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

/// Matches the shared mockup's role-selection checkbox row: a labeled
/// checkbox with a short subtitle and a cook-themed icon, rather than a
/// bare `CheckboxListTile`.
class _RegisterAsCookToggle extends StatelessWidget {
  const _RegisterAsCookToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.input),
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.all(AppSpace.m),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppRadius.input),
          border: Border.all(color: scheme.outline),
        ),
        child: Row(
          children: [
            Checkbox(value: value, onChanged: (v) => onChanged(v ?? false)),
            const SizedBox(width: AppSpace.xs),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('التسجيل كطباخة', style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    'أرغب في تقديم وجباتي عبر المنصة',
                    style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.soup_kitchen_outlined, color: scheme.primary),
          ],
        ),
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
