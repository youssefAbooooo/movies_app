import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/services/account_datails_service.dart';
import 'package:movies_app/services/authentication_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TMDBAuthService _authService = TMDBAuthService();

  LoginCubit() : super(LoginInitial());

  Future<void> getRequestToken() async {
    try {
      emit(LoginLoading());
      final token = await _authService.getRequestToken();
      if (token != null) {
        emit(LoginRequestTokenReceived(token));
      } else {
        emit(LoginFailure('Failed to get request token'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  Future<void> completeLogin(String requestToken) async {
    try {
      emit(LoginLoading());
      final sessionId = await _authService.getSessionId(requestToken);
      if (sessionId != null) {
        await AccountDetailsService().setSessionId(sessionId);
        await _authService.storeAccountDetails(sessionId);

        emit(LoginSuccess(sessionId));
      } else {
        emit(LoginFailure('Failed to get session ID'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
