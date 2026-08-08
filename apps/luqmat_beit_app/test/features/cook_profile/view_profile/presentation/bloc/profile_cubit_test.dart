import '../../../../../support/bloc_test_helper.dart';
import 'package:luqmat_beit_app/features/cook_profile/domain/cook_profile_details.dart';
import 'package:luqmat_beit_app/features/cook_profile/view_profile/domain/usecases/get_cook_profile.dart';
import 'package:luqmat_beit_app/features/cook_profile/view_profile/presentation/bloc/profile_cubit.dart';
import 'package:luqmat_beit_app/features/cook_profile/view_profile/presentation/bloc/profile_state.dart';
import 'package:luqmat_beit_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCookProfile extends Mock implements GetCookProfile {}

void main() {
  late _MockGetCookProfile getCookProfile;

  setUp(() {
    getCookProfile = _MockGetCookProfile();
  });

  const profile = CookProfileDetails(
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

  blocTest<ProfileCubit, ProfileState>(
    'emits [loading, loaded] with the profile the repository returns',
    setUp: () {
      when(() => getCookProfile(currentCookId)).thenAnswer(
        (_) async => const Result.success(profile),
      );
    },
    build: () => ProfileCubit(getCookProfile),
    act: (cubit) => cubit.loadProfile(),
    expect: () => [
      const ProfileState.loading(),
      const ProfileState.loaded(profile),
    ],
  );

  blocTest<ProfileCubit, ProfileState>(
    'emits [loading, error] when the repository call fails',
    setUp: () {
      when(() => getCookProfile(currentCookId)).thenAnswer(
        (_) async => const Result.failure(NetworkException()),
      );
    },
    build: () => ProfileCubit(getCookProfile),
    act: (cubit) => cubit.loadProfile(),
    expect: () => [
      const ProfileState.loading(),
      const ProfileState.error(NetworkException()),
    ],
  );
}
