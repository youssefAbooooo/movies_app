import 'dart:nativewrappers/_internal/vm/lib/developer.dart';

import 'package:dio/dio.dart';

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
}
