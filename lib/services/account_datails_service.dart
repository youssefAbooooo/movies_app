import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailsService {
  //This is a singleton instance of the GetAccountDetailsService class.
  //It ensures that only one instance of this class exists across the whole app.
  static final AccountDetailsService _instance =
      AccountDetailsService._internal();
  late SharedPreferences _prefs;

  //Every time you write GetSessionIdService(), it returns the same instance (singleton behavior).
  factory AccountDetailsService() {
    return _instance;
  }

  AccountDetailsService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setSessionId(String sessionId) async {
    await _prefs.setString('session_id', sessionId);
  }

  Future<void> setAccountId(int accountId) async {
    await _prefs.setInt('account_id', accountId);
  }

  Future<void> setUsername(String username) async {
    await _prefs.setString('username', username);
  }

  String? getSessionId() {
    return _prefs.getString('session_id');
  }

  int? getAccountId() {
    return _prefs.getInt('account_id');
  }

  String? getUsername() {
    return _prefs.getString('username');
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
