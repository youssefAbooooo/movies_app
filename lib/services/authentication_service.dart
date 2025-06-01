import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies_app/models/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = await SharedPreferences.getInstance();

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
        await prefs.setInt('account_id', accountId);
        await prefs.setString('username', username);

        log('Account details saved: $username (ID: $accountId)');
      } else {
        throw Exception(
            'Failed to fetch account details. Status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }

  Future<Account> getAccountDetails() async {
    final prefs = await SharedPreferences.getInstance();
    late Account account;
    if (prefs.getInt('account_id') != null &&
        prefs.getString('username') != null) {
      account = Account(
        id: prefs.getInt('account_id')!,
        username: prefs.getString('username')!,
      );
    }
    return account;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('session_id');
    await prefs.remove('account_id');
    await prefs.remove('username');
    // Or: await prefs.clear(); // to remove everything
  }
}
