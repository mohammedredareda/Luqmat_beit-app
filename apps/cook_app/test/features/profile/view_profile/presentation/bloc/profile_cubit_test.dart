import 'package:bloc_test/bloc_test.dart';
import 'package:cook_app/features/profile/view_profile/domain/usecases/get_cook_profile.dart';
import 'package:cook_app/features/profile/view_profile/presentation/bloc/profile_cubit.dart';
import 'package:cook_app/features/profile/view_profile/presentation/bloc/profile_state.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetCookProfile extends Mock implements GetCookProfile {}

void main() {
  late _MockGetCookProfile getCookProfile;

  setUp(() {
    getCookProfile = _MockGetCookProfile();
  });

  const profile = CookProfileEntity(
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
