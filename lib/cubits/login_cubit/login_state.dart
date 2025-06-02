part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginRequestTokenReceived extends LoginState {
  final String requestToken;

  LoginRequestTokenReceived(this.requestToken);
}

class LoginSuccess extends LoginState {
  final String sessionId;

  LoginSuccess(this.sessionId);
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
