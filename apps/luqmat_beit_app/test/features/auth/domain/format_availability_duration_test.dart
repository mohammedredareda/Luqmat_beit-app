import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luqmat_beit_app/features/auth/domain/format_availability_duration.dart';

void main() {
  group('weekdayRangeToIsoDays', () {
    test('a Sat-Thu range wraps through the week and maps to ISO weekday numbers', () {
      final result = weekdayRangeToIsoDays(startDay: Weekday.sat, endDay: Weekday.thu);
      expect(result, [6, 7, 1, 2, 3, 4]);
    });

    test('a Mon-Fri range matches the confirmed API example [1, 2, 3, 4, 5]', () {
      final result = weekdayRangeToIsoDays(startDay: Weekday.mon, endDay: Weekday.fri);
      expect(result, [1, 2, 3, 4, 5]);
    });

    test('a single-day range returns just that day', () {
      final result = weekdayRangeToIsoDays(startDay: Weekday.mon, endDay: Weekday.mon);
      expect(result, [1]);
    });
  });

  group('timeOfDayToDateTime', () {
    test('anchors the time-of-day to a fixed UTC date', () {
      final result = timeOfDayToDateTime(const TimeOfDay(hour: 10, minute: 30));
      expect(result, DateTime.utc(2024, 1, 1, 10, 30));
      expect(result.isUtc, isTrue);
    });
  });
}
