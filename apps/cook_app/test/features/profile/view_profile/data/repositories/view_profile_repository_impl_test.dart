import 'package:cook_app/features/profile/data/datasources/fake_cook_profile_remote_data_source.dart';
import 'package:cook_app/features/profile/domain/cook_profile_details.dart';
import 'package:cook_app/features/profile/view_profile/data/repositories/view_profile_repository_impl.dart';
import 'package:cook_app/shared/current_cook_id.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProfile returns a Success with the correctly mapped entity', () async {
    final repository = ViewProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile(currentCookId);

    expect(result, isA<Success<CookProfileDetails>>());
    final details = (result as Success<CookProfileDetails>).data;
    expect(details.profile.id, currentCookId);
    expect(details.profile.name, 'أم أحمد');
    expect(details.profile.availabilityTime, '10:00-18:00');
  });

  test('getProfile with an unknown id returns a Failure', () async {
    final repository = ViewProfileRepositoryImpl(FakeCookProfileRemoteDataSource());

    final result = await repository.getProfile('cook-does-not-exist');

    expect(result, isA<Failure<CookProfileDetails>>());
    expect((result as Failure<CookProfileDetails>).exception, isA<NotFoundException>());
  });
}
