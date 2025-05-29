import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthenticaionService {
  final dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = '89d29d819af376ca1df5e06d6e7e3751';

  Future<Map<String, dynamic>> authenticate() async {
    late String requestToken;
    late String sessionId;
    late Map<String, dynamic> accountDetails;
    try {
      //? Step 1: create a request token
      Response response = await dio.get(
          'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonData = response.data;
        requestToken = jsonData['request_token'];
      } else {
        throw Exception('Failed to create request token');
      }

      //? Step 2: User authorization (redirect to TMDB website)
      final url =
          Uri.parse('https://www.themoviedb.org/authenticate/$requestToken');
      if (await canLaunchUrl(url)) {
        await launchUrl(
          url,
          mode: LaunchMode.externalApplication, // Opens in browser
        );
      }

      //? Step 3: Create session (call this after user returns)
      final response1 = await dio.post(
        'https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey',
        data: {'request_token': requestToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response1.statusCode == 200) {
        sessionId = response1.data['session_id'];
      } else {
        throw Exception('Failed to create session');
      }

      //? Step 4: Get account details
      final response2 = await dio
          .get('$baseUrl/account?api_key=$apiKey&session_id=$sessionId');
      if (response2.statusCode == 200) {
        accountDetails = response2.data;
      } else {
        throw Exception('Failed to get account details');
      }

      //? returning account data
      return {
        'session_id': sessionId,
        'account_id': accountDetails['id'],
        'username': accountDetails['username'],
      };
    } catch (e) {
      throw Exception('Authentication Failed: $e');
    }
  }
}
