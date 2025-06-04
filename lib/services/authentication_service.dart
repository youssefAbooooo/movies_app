import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/services/account_datails_service.dart';

class TMDBAuthService {
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751'; // 🔑 Replace this
  final Dio dio = Dio();

  Future<String?> getRequestToken() async {
    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new',
        queryParameters: {'api_key': apiKey},
      );
      return response.data['request_token'];
    } catch (e) {
      log('Error getting request token: $e');
      return null;
    }
  }

  Future<String?> getSessionId(String requestToken) async {
    try {
      final response = await dio.post(
        'https://api.themoviedb.org/3/authentication/session/new',
        queryParameters: {'api_key': apiKey},
        data: {'request_token': requestToken},
      );
      return response.data['session_id'];
    } catch (e) {
      log('Error creating session ID: $e');
      return null;
    }
  }

  Future<void> storeAccountDetails(String? sessionId) async {
    if (sessionId == null) {
      throw Exception('Session ID not found. User might not be logged in.');
    }

    try {
      final response = await dio.get(
        'https://api.themoviedb.org/3/account',
        queryParameters: {
          'api_key': apiKey,
          'session_id': sessionId,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final accountId = data['id'];
        final username = data['username'];

        // Store in SharedPreferences
        await AccountDetailsService().setAccountId(accountId);
        await AccountDetailsService().setUsername(username);

        log('Account details saved: $username (ID: $accountId)');
      } else {
        throw Exception(
            'Failed to fetch account details. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<void> logout() async {
    await AccountDetailsService().clearAll();
  }
}
