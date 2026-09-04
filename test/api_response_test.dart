import 'package:flutter_secure_api/flutter_secure_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiResponse', () {
    test('returns true for successful response', () {
      const response = ApiResponse<String>(
        data: 'Success',
        statusCode: 200,
        headers: {},
      );

      expect(response.isSuccess, true);
      expect(response.data, 'Success');
    });

    test('returns false for failed response', () {
      const response = ApiResponse<String>(
        data: null,
        statusCode: 401,
        headers: {},
      );

      expect(response.isSuccess, false);
    });
  });
}