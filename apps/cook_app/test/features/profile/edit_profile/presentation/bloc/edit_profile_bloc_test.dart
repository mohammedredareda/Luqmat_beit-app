import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/profile/domain/profile_form_submission.dart';
import 'package:cook_app/features/profile/edit_profile/domain/usecases/get_cook_profile.dart';
import 'package:cook_app/features/profile/edit_profile/domain/usecases/update_cook_profile.dart';
import 'package:cook_app/features/profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:cook_app/features/profile/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:cook_app/features/profile/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:cook_app/features/profile/edit_profile/presentation/bloc/profile_submit_status.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCookProfile extends Mock implements GetCookProfile {}

class _MockUpdateCookProfile extends Mock implements UpdateCookProfile {}

void main() {
  late _MockGetCookProfile getCookProfile;
  late _MockUpdateCookProfile updateCookProfile;

  setUpAll(() {
    registerFallbackValue(const ProfileFormSubmission(
      fullName: '',
      phoneNumber: '',
      bio: '',
      address: '',
      availabilityDays: {},
      availabilityStartTime: AvailabilityTime(hour: 9, minute: 0),
      availabilityEndTime: AvailabilityTime(hour: 17, minute: 0),
    ));
  });

  setUp(() {
    getCookProfile = _MockGetCookProfile();
    updateCookProfile = _MockUpdateCookProfile();
  });

  const existingProfile = CookProfileEntity(
    id: currentCookId,
    fullName: 'أم أحمد',
    phoneNumber: '+966 50 123 4567',
    bio: 'نبذة',
    address: 'الرياض',
    availabilityDays: {Weekday.sunday, Weekday.thursday},
    availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
    availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
    rating: 4.9,
    reviewCount: 120,
    completedOrdersCount: 124,
    totalMealsCount: 15,
  );

  const validFormData = EditProfileFormData(
    fullName: 'أم أحمد',
    phoneNumber: '+966 50 123 4567',
    bio: 'نبذة',
    address: 'الرياض',
    availabilityDays: {Weekday.sunday, Weekday.thursday},
    availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
    availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'started with a successful GetCookProfile emits [loading, form(prefilled)]',
    setUp: () {
      when(() => getCookProfile(currentCookId)).thenAnswer(
        (_) async => const Result.success(existingProfile),
      );
    },
    build: () => EditProfileBloc(getCookProfile, updateCookProfile),
    act: (bloc) => bloc.add(const EditProfileEvent.started()),
    expect: () => [
      const EditProfileState.loading(),
      const EditProfileState.form(validFormData),
    ],
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'started with a failing GetCookProfile emits [loading, loadError]',
    setUp: () {
      when(() => getCookProfile(currentCookId)).thenAnswer(
        (_) async => const Result.failure(NotFoundException('Profile not found')),
      );
    },
    build: () => EditProfileBloc(getCookProfile, updateCookProfile),
    act: (bloc) => bloc.add(const EditProfileEvent.started()),
    expect: () => [
      const EditProfileState.loading(),
      const EditProfileState.loadError(NotFoundException('Profile not found')),
    ],
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'submitPressed on a valid loaded form emits [submitting, success]',
    setUp: () {
      when(() => updateCookProfile(currentCookId, any())).thenAnswer(
        (_) async => const Result.success(existingProfile),
      );
    },
    build: () => EditProfileBloc(getCookProfile, updateCookProfile),
    seed: () => const EditProfileState.form(validFormData),
    act: (bloc) => bloc.add(const EditProfileEvent.submitPressed()),
    expect: () => [
      const EditProfileState.form(
        EditProfileFormData(
          fullName: 'أم أحمد',
          phoneNumber: '+966 50 123 4567',
          bio: 'نبذة',
          address: 'الرياض',
          availabilityDays: {Weekday.sunday, Weekday.thursday},
          availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
          availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
          submitStatus: ProfileSubmitStatus.submitting(),
        ),
      ),
      const EditProfileState.form(
        EditProfileFormData(
          fullName: 'أم أحمد',
          phoneNumber: '+966 50 123 4567',
          bio: 'نبذة',
          address: 'الرياض',
          availabilityDays: {Weekday.sunday, Weekday.thursday},
          availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
          availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
          submitStatus: ProfileSubmitStatus.success(existingProfile),
        ),
      ),
    ],
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'submitPressed with an empty fullName emits validationFailure and never calls updateCookProfile',
    build: () => EditProfileBloc(getCookProfile, updateCookProfile),
    seed: () => const EditProfileState.form(EditProfileFormData(
      fullName: '',
      phoneNumber: '+966 50 123 4567',
      bio: 'نبذة',
      address: 'الرياض',
      availabilityDays: {Weekday.sunday, Weekday.thursday},
      availabilityStartTime: AvailabilityTime(hour: 10, minute: 0),
      availabilityEndTime: AvailabilityTime(hour: 18, minute: 0),
    )),
    act: (bloc) => bloc.add(const EditProfileEvent.submitPressed()),
    expect: () => [
      isA<EditProfileState>().having(
        (s) => (s as EditProfileForm).data.submitStatus,
        'submitStatus',
        isA<ProfileSubmitValidationFailure>(),
      ),
    ],
    verify: (_) => verifyNever(() => updateCookProfile(any(), any())),
  );
}
