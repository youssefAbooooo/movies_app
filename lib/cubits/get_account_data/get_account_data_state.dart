part of 'get_account_data_cubit.dart';

@immutable
sealed class GetAccountDataState {}

final class GetAccountDataInitial extends GetAccountDataState {}

class GetAccountDataLoading extends GetAccountDataState {}

class GetAccountDataSuccess extends GetAccountDataState {
  final int accountId;
  final String userName;
  final String sessionId;

  GetAccountDataSuccess({
    required this.accountId,
    required this.sessionId,
    required this.userName,
  });
}

class GetAccountDataFailed extends GetAccountDataState {
  final String error;

  GetAccountDataFailed(this.error);
}
