import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luqmat_beit_app/features/auth/domain/format_availability_duration.dart';

void main() {
  test('joins day-range and time-range into the backend\'s single string format', () {
    final result = formatAvailabilityDuration(
      startDay: Weekday.sat,
      endDay: Weekday.thu,
      startTime: const TimeOfDay(hour: 10, minute: 0),
      endTime: const TimeOfDay(hour: 20, minute: 0),
    );

    expect(result, 'Sat-Thu, 10:00 AM - 08:00 PM');
  });

  test('formats single-digit hours with a leading zero, matching the API example', () {
    final result = formatAvailabilityDuration(
      startDay: Weekday.sun,
      endDay: Weekday.fri,
      startTime: const TimeOfDay(hour: 9, minute: 5),
      endTime: const TimeOfDay(hour: 17, minute: 30),
    );

    expect(result, 'Sun-Fri, 09:05 AM - 05:30 PM');
  });

  test('midnight and noon format as 12, not 00', () {
    final result = formatAvailabilityDuration(
      startDay: Weekday.mon,
      endDay: Weekday.mon,
      startTime: const TimeOfDay(hour: 0, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
    );

    expect(result, 'Mon-Mon, 12:00 AM - 12:00 PM');
  });
}
