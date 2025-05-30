import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticaionService {
  final dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751';

  Future<Map<String, dynamic>> authenticate() async {
    try {
      // Step 1: create a request token
      final String requestToken = await createRequestToken();

      // Step 2: User authorization (redirect to TMDB website)
      authorizeUser(requestToken);

      // Step 3: Create session (call this after user returns)
      final String sessionId = await createSession(requestToken);

      // Step 4: Get account details
      final accountDetails = await getAccountDetails(sessionId);

      // returning account data
      return {
        'session_id': sessionId,
        'account_id': accountDetails['id'],
        'username': accountDetails['username'],
      };
    } catch (e) {
      throw Exception('Authentication Failed: $e');
    }
  }

  Future<String> createRequestToken() async {
    Response response = await dio.get(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = response.data;
      log('request token is: ${jsonData['request_token']}');
      debugPrint('request token is: ${jsonData['request_token']}');
      return jsonData['request_token'];
    } else {
      throw Exception('Failed to create request token');
    }
  }

  void authorizeUser(String requestToken) async {
    final url = 'https://www.themoviedb.org/authenticate/$requestToken';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  Future<String> createSession(String requestToken) async {
    final response = await dio.post(
      'https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey',
      data: {'request_token': requestToken},
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );
    if (response.statusCode == 200) {
      return response.data['session_id'];
    } else {
      throw Exception('Failed to create session');
    }
  }

  Future<Map<String, dynamic>> getAccountDetails(String sessionId) async {
    final response =
        await dio.get('$baseUrl/account?api_key=$apiKey&session_id=$sessionId');

    if (response.statusCode == 200) {
      return response.data;
    }
    throw Exception('Failed to get account details');
  }
}
