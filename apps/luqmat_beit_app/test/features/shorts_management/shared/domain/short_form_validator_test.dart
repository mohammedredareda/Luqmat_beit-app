import 'package:luqmat_beit_app/features/shorts_management/shared/domain/short_form_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('a fully valid submission has no errors', () {
    final errors = validateShortForm(videoPath: '/tmp/short.mp4', description: 'وصف شهي');

    expect(errors, isEmpty);
  });

  test('no video picked is required', () {
    final errors = validateShortForm(videoPath: null, description: 'وصف شهي');

    expect(errors['video'], contains('required'));
  });

  test('an empty video path is required', () {
    final errors = validateShortForm(videoPath: '', description: 'وصف شهي');

    expect(errors['video'], contains('required'));
  });

  test('an empty description is required', () {
    final errors = validateShortForm(videoPath: '/tmp/short.mp4', description: '   ');

    expect(errors['description'], contains('required'));
  });

  test('a description over the 300-char cap is too long', () {
    final errors = validateShortForm(
      videoPath: '/tmp/short.mp4',
      description: 'a' * (maxShortDescriptionLength + 1),
    );

    expect(errors['description'], contains('tooLong'));
  });

  test('a description exactly at the 300-char cap is valid', () {
    final errors = validateShortForm(
      videoPath: '/tmp/short.mp4',
      description: 'a' * maxShortDescriptionLength,
    );

    expect(errors, isEmpty);
  });
}
