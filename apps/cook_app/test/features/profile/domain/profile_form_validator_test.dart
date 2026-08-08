import 'package:cook_app/features/profile/domain/profile_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validStart = '09:00';
  const validEnd = '17:00';

  Map<String, List<String>> validate({
    String? fullName,
    String? address,
    String? availabilityStartTime,
    String? availabilityEndTime,
    int avatarSizeBytes = 1024,
  }) =>
      validateProfileForm(
        fullName: fullName ?? 'أم أحمد',
        address: address ?? 'حي الياسمين، الرياض',
        availabilityStartTime: availabilityStartTime ?? validStart,
        availabilityEndTime: availabilityEndTime ?? validEnd,
        avatarSizeBytes: avatarSizeBytes,
      );

  test('a fully valid submission returns an empty error map', () {
    expect(validate(), isEmpty);
  });

  test('empty fullName is required', () {
    expect(validate(fullName: '  ')['fullName'], contains('required'));
  });

  test('empty address is required', () {
    expect(validate(address: '')['address'], contains('required'));
  });

  test('end time equal to start time is an invalid range', () {
    expect(
      validate(availabilityStartTime: validStart, availabilityEndTime: validStart)['availabilityHours'],
      contains('invalidRange'),
    );
  });

  test('end time before start time is an invalid range', () {
    expect(
      validate(
        availabilityStartTime: '17:00',
        availabilityEndTime: '09:00',
      )['availabilityHours'],
      contains('invalidRange'),
    );
  });

  test('avatar over the 10 MB cap is imageTooLarge', () {
    expect(
      validate(avatarSizeBytes: maxProfileImageBytes + 1)['avatar'],
      contains('imageTooLarge'),
    );
  });

  test('null avatarSizeBytes (no new photo picked) is not an error', () {
    final errors = validateProfileForm(
      fullName: 'أم أحمد',
      address: 'حي الياسمين، الرياض',
      availabilityStartTime: validStart,
      availabilityEndTime: validEnd,
      avatarSizeBytes: null,
    );
    expect(errors.containsKey('avatar'), isFalse);
  });
}
