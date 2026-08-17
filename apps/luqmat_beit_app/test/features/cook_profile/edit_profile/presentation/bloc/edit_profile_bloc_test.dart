import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/cook_profile/domain/cook_profile_details.dart';
import 'package:luqmat_beit_app/features/cook_profile/domain/profile_form_submission.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/domain/usecases/get_cook_profile.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/domain/usecases/update_cook_profile.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/presentation/bloc/edit_profile_event.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/presentation/bloc/edit_profile_state.dart';
import 'package:luqmat_beit_app/features/cook_profile/edit_profile/presentation/bloc/profile_submit_status.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCookProfile extends Mock implements GetCookProfile {}

class _MockUpdateCookProfile extends Mock implements UpdateCookProfile {}

class _MockDetectCurrentLocation extends Mock implements DetectCurrentLocation {}

void main() {
  late _MockGetCookProfile getCookProfile;
  late _MockUpdateCookProfile updateCookProfile;
  late _MockDetectCurrentLocation detectCurrentLocation;

  setUpAll(() {
    registerFallbackValue(const ProfileFormSubmission(
      fullName: '',
      phoneNumber: '',
      bio: '',
      address: '',
      availabilityStartTime: '09:00',
      availabilityEndTime: '17:00',
    ));
  });

  setUp(() {
    getCookProfile = _MockGetCookProfile();
    updateCookProfile = _MockUpdateCookProfile();
    detectCurrentLocation = _MockDetectCurrentLocation();
  });

  const existingProfile = CookProfileDetails(
    profile: CookProfileEntity(
      id: currentCookId,
      name: 'أم أحمد',
      description: 'نبذة',
      availabilityTime: '10:00-18:00',
      rate: 4.9,
      ratingCount: 120,
    ),
    phoneNumber: '+966 50 123 4567',
    address: 'الرياض',
  );

  const validFormData = EditProfileFormData(
    fullName: 'أم أحمد',
    phoneNumber: '+966 50 123 4567',
    bio: 'نبذة',
    address: 'الرياض',
    availabilityStartTime: '10:00',
    availabilityEndTime: '18:00',
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'started with a successful GetCookProfile emits [loading, form(prefilled)]',
    setUp: () {
      when(() => getCookProfile(currentCookId)).thenAnswer(
        (_) async => const Result.success(existingProfile),
      );
    },
    build: () => EditProfileBloc(getCookProfile, updateCookProfile, detectCurrentLocation),
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
    build: () => EditProfileBloc(getCookProfile, updateCookProfile, detectCurrentLocation),
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
    build: () => EditProfileBloc(getCookProfile, updateCookProfile, detectCurrentLocation),
    seed: () => const EditProfileState.form(validFormData),
    act: (bloc) => bloc.add(const EditProfileEvent.submitPressed()),
    expect: () => [
      const EditProfileState.form(
        EditProfileFormData(
          fullName: 'أم أحمد',
          phoneNumber: '+966 50 123 4567',
          bio: 'نبذة',
          address: 'الرياض',
          availabilityStartTime: '10:00',
          availabilityEndTime: '18:00',
          submitStatus: ProfileSubmitStatus.submitting(),
        ),
      ),
      const EditProfileState.form(
        EditProfileFormData(
          fullName: 'أم أحمد',
          phoneNumber: '+966 50 123 4567',
          bio: 'نبذة',
          address: 'الرياض',
          availabilityStartTime: '10:00',
          availabilityEndTime: '18:00',
          submitStatus: ProfileSubmitStatus.success(existingProfile),
        ),
      ),
    ],
  );

  blocTest<EditProfileBloc, EditProfileState>(
    'submitPressed with an empty fullName emits validationFailure and never calls updateCookProfile',
    build: () => EditProfileBloc(getCookProfile, updateCookProfile, detectCurrentLocation),
    seed: () => const EditProfileState.form(EditProfileFormData(
      fullName: '',
      phoneNumber: '+966 50 123 4567',
      bio: 'نبذة',
      address: 'الرياض',
      availabilityStartTime: '10:00',
      availabilityEndTime: '18:00',
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
