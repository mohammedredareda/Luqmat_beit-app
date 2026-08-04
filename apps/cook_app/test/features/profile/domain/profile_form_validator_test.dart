import 'package:cook_app/features/profile/domain/profile_form_validator.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validDays = {Weekday.sunday, Weekday.monday};
  const validStart = AvailabilityTime(hour: 9, minute: 0);
  const validEnd = AvailabilityTime(hour: 17, minute: 0);

  Map<String, List<String>> validate({
    String? fullName,
    String? phoneNumber,
    String? address,
    Set<Weekday>? availabilityDays,
    AvailabilityTime? availabilityStartTime,
    AvailabilityTime? availabilityEndTime,
    int avatarSizeBytes = 1024,
  }) =>
      validateProfileForm(
        fullName: fullName ?? 'أم أحمد',
        phoneNumber: phoneNumber ?? '+966 50 123 4567',
        address: address ?? 'حي الياسمين، الرياض',
        availabilityDays: availabilityDays ?? validDays,
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

  test('empty phoneNumber is required', () {
    expect(validate(phoneNumber: '')['phoneNumber'], contains('required'));
  });

  test('empty address is required', () {
    expect(validate(address: '')['address'], contains('required'));
  });

  test('zero availability days is rejected', () {
    expect(validate(availabilityDays: const {})['availabilityDays'], contains('zeroDays'));
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
        availabilityStartTime: const AvailabilityTime(hour: 17, minute: 0),
        availabilityEndTime: const AvailabilityTime(hour: 9, minute: 0),
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
      phoneNumber: '+966 50 123 4567',
      address: 'حي الياسمين، الرياض',
      availabilityDays: validDays,
      availabilityStartTime: validStart,
      availabilityEndTime: validEnd,
      avatarSizeBytes: null,
    );
    expect(errors.containsKey('avatar'), isFalse);
  });
}
