import 'package:flutter_app_template/core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneFormatter', () {
    group('toE164 method', () {
      test('should return null when input has no digits', () {
        // Arrange
        const String input = 'abc---';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, isNull);
      });

      test(
        'should return +998 + 9 digits when input is 9-digit local number',
        () {
          // Arrange
          const String input = '901234567';

          // Act
          final String? result = PhoneFormatter.toE164(input);

          // Assert
          expect(result, equals('+998901234567'));
        },
      );

      test('should normalize formatted local number with non-digits', () {
        // Arrange
        const String input = '(90) 123-45-67';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, equals('+998901234567'));
      });

      test('should return +digits when input already has 998 + 9 digits', () {
        // Arrange
        const String input = '998901234567';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, equals('+998901234567'));
      });

      test('should normalize formatted full number with plus sign', () {
        // Arrange
        const String input = '+998 (90) 123-45-67';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, equals('+998901234567'));
      });

      test('should remove leading 00 international prefix', () {
        // Arrange
        const String input = '00 998 90 123 45 67';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, equals('+998901234567'));
      });

      test(
        'should return null for 998-prefixed number with invalid length',
        () {
          // Arrange
          const String input = '99890123456';

          // Act
          final String? result = PhoneFormatter.toE164(input);

          // Assert
          expect(result, isNull);
        },
      );

      test('should return null for local number with invalid length', () {
        // Arrange
        const String input = '90123456';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, isNull);
      });

      test('should return null for number longer than supported formats', () {
        // Arrange
        const String input = '9989012345678';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, isNull);
      });

      test('should return null when digits are 9 long but start with 998', () {
        // Arrange
        const String input = '998123456';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, isNull);
      });

      test('should return null for non-Uzbek full international number', () {
        // Arrange
        const String input = '+1 (202) 555-0123';

        // Act
        final String? result = PhoneFormatter.toE164(input);

        // Assert
        expect(result, isNull);
      });
    });
  });
}
