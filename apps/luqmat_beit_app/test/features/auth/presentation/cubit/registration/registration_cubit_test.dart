import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luqmat_beit_app/features/auth/domain/format_availability_duration.dart';
import 'package:luqmat_beit_app/features/auth/domain/usecases/register.dart';
import 'package:luqmat_beit_app/features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'package:luqmat_beit_app/features/auth/presentation/cubit/registration/registration_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../support/bloc_test_helper.dart';

class _MockRegister extends Mock implements Register {}

class _MockDetectCurrentLocation extends Mock implements DetectCurrentLocation {}

void main() {
  late _MockRegister register;
  late _MockDetectCurrentLocation detectCurrentLocation;

  // RegistrationState's defaults (see registration_state.dart).
  final defaultStartAvailability = timeOfDayToDateTime(const TimeOfDay(hour: 10, minute: 0));
  final defaultEndAvailability = timeOfDayToDateTime(const TimeOfDay(hour: 20, minute: 0));
  final defaultAvailabilityDays =
      weekdayRangeToIsoDays(startDay: Weekday.sat, endDay: Weekday.thu);

  setUpAll(() {
    // mocktail needs a fallback value for any type used with `any(named:)`
    // in a `when`/`verify` call — `UserRole` is a plain enum with no
    // built-in fallback.
    registerFallbackValue(UserRole.customer);
  });

  setUp(() {
    register = _MockRegister();
    detectCurrentLocation = _MockDetectCurrentLocation();
  });

  RegistrationCubit buildCubit() => RegistrationCubit(register, detectCurrentLocation);

  void stubRegisterSuccess() {
    when(() => register(
          role: any(named: 'role'),
          name: any(named: 'name'),
          phone: any(named: 'phone'),
          password: any(named: 'password'),
          address: any(named: 'address'),
          description: any(named: 'description'),
          startAvailabilityTime: any(named: 'startAvailabilityTime'),
          endAvailabilityTime: any(named: 'endAvailabilityTime'),
          availabilityDays: any(named: 'availabilityDays'),
          latitude: any(named: 'latitude'),
          longitude: any(named: 'longitude'),
        )).thenAnswer((_) async => const Result.success(null));
  }

  group('customer registration (registerAsCook left false)', () {
    blocTest<RegistrationCubit, RegistrationState>(
      'submit with an empty name blocks submission and never calls the usecase',
      build: buildCubit,
      act: (cubit) {
        cubit.phoneChanged('0912345678');
        cubit.passwordChanged('Password123!');
        cubit.addressChanged('حلب، حي الشهباء');
        return cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.submitError, isNotNull);
        expect(cubit.state.success, isFalse);
        verifyNever(() => register(
              role: any(named: 'role'),
              name: any(named: 'name'),
              phone: any(named: 'phone'),
              password: any(named: 'password'),
              address: any(named: 'address'),
              description: any(named: 'description'),
              startAvailabilityTime: any(named: 'startAvailabilityTime'),
              endAvailabilityTime: any(named: 'endAvailabilityTime'),
              availabilityDays: any(named: 'availabilityDays'),
              latitude: any(named: 'latitude'),
              longitude: any(named: 'longitude'),
            ));
      },
    );

    blocTest<RegistrationCubit, RegistrationState>(
      'a fully valid submission calls the usecase with role customer and no cook fields',
      setUp: stubRegisterSuccess,
      build: buildCubit,
      act: (cubit) {
        cubit.fullNameChanged('سارة أحمد');
        cubit.phoneChanged('0912345678');
        cubit.passwordChanged('Password123!');
        cubit.addressChanged('حلب، حي الشهباء');
        return cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.success, isTrue);
        expect(cubit.state.submitError, isNull);
        verify(() => register(
              role: UserRole.customer,
              name: 'سارة أحمد',
              phone: '0912345678',
              password: 'Password123!',
              address: 'حلب، حي الشهباء',
              description: null,
              startAvailabilityTime: null,
              endAvailabilityTime: null,
              availabilityDays: null,
              latitude: null,
              longitude: null,
            )).called(1);
      },
    );
  });

  group('cook registration (registerAsCook toggled on)', () {
    blocTest<RegistrationCubit, RegistrationState>(
      'submit with the cook toggle on but an empty description blocks submission',
      build: buildCubit,
      act: (cubit) {
        cubit.fullNameChanged('الشيف عبدو');
        cubit.phoneChanged('0912345678');
        cubit.passwordChanged('Password123!');
        cubit.addressChanged('حلب، حي الشهباء');
        cubit.registerAsCookChanged(true);
        return cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.submitError, isNotNull);
        expect(cubit.state.success, isFalse);
      },
    );

    blocTest<RegistrationCubit, RegistrationState>(
      'a fully valid cook submission calls the usecase with role cook and the structured availability fields',
      setUp: stubRegisterSuccess,
      build: buildCubit,
      act: (cubit) {
        cubit.fullNameChanged('الشيف عبدو');
        cubit.phoneChanged('0912345678');
        cubit.passwordChanged('Password123!');
        cubit.addressChanged('حلب، حي الشهباء');
        cubit.registerAsCookChanged(true);
        cubit.descriptionChanged('طباخ محترف');
        return cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.success, isTrue);
        expect(cubit.state.submitError, isNull);
        verify(() => register(
              role: UserRole.cook,
              name: 'الشيف عبدو',
              phone: '0912345678',
              password: 'Password123!',
              address: 'حلب، حي الشهباء',
              description: 'طباخ محترف',
              startAvailabilityTime: defaultStartAvailability,
              endAvailabilityTime: defaultEndAvailability,
              availabilityDays: defaultAvailabilityDays,
              latitude: null,
              longitude: null,
            )).called(1);
      },
    );

    blocTest<RegistrationCubit, RegistrationState>(
      'toggling the cook checkbox back off drops the cook-only requirement',
      setUp: stubRegisterSuccess,
      build: buildCubit,
      act: (cubit) {
        cubit.fullNameChanged('سارة أحمد');
        cubit.phoneChanged('0912345678');
        cubit.passwordChanged('Password123!');
        cubit.addressChanged('حلب، حي الشهباء');
        cubit.registerAsCookChanged(true);
        cubit.registerAsCookChanged(false);
        return cubit.submit();
      },
      verify: (cubit) {
        expect(cubit.state.success, isTrue);
        verify(() => register(
              role: UserRole.customer,
              name: 'سارة أحمد',
              phone: '0912345678',
              password: 'Password123!',
              address: 'حلب، حي الشهباء',
              description: null,
              startAvailabilityTime: null,
              endAvailabilityTime: null,
              availabilityDays: null,
              latitude: null,
              longitude: null,
            )).called(1);
      },
    );
  });
}
