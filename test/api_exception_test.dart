import 'package:flutter_secure_api/flutter_secure_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiException', () {
    test('creates exception with status code', () {
      const exception = ApiException(
        message: 'Unauthorized',
        statusCode: 401,
      );

      expect(exception.message, 'Unauthorized');
      expect(exception.statusCode, 401);
      expect(
        exception.toString(),
        'ApiException(401): Unauthorized',
      );
    });
  });
}