import 'package:cook_app/features/profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import 'package:cook_app/features/profile/view_profile/data/repositories/view_profile_repository_impl.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProfile returns a Success with the correctly mapped entity', () async {
    final repository = ViewProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile(currentCookId);

    expect(result, isA<Success<CookProfileEntity>>());
    final profile = (result as Success<CookProfileEntity>).data;
    expect(profile.id, currentCookId);
    expect(profile.fullName, 'أم أحمد');
    expect(profile.completedOrdersCount, 124);
    expect(profile.totalMealsCount, 15);
  });

  test('getProfile with an unknown id returns a Failure', () async {
    final repository = ViewProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile('cook-does-not-exist');

    expect(result, isA<Failure<CookProfileEntity>>());
    expect((result as Failure<CookProfileEntity>).exception, isA<NotFoundException>());
  });
}
