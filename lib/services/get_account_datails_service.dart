import 'package:shared_preferences/shared_preferences.dart';

class GetAccountDetailsService {
  //This is a singleton instance of the SessionService class.
  //It ensures that only one instance of this class exists across the whole app.
  static final GetAccountDetailsService _instance =
      GetAccountDetailsService._internal();
  late SharedPreferences _prefs;

  //Every time you write GetSessionIdService(), it returns the same instance (singleton behavior).
  factory GetAccountDetailsService() {
    return _instance;
  }

  GetAccountDetailsService._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
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
}
