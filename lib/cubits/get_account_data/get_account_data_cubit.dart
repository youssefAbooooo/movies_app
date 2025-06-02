import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'get_account_data_state.dart';

class GetAccountDataCubit extends Cubit<GetAccountDataState> {
  GetAccountDataCubit() : super(GetAccountDataInitial());

  Future<void> getAccountData() async {
    try {
      emit(GetAccountDataLoading());
      final prefs = await SharedPreferences.getInstance();
      final accountId = prefs.getInt('account_id');
      final username = prefs.getString('username');
      final sessionId = prefs.getString('session_id');

      if (accountId != null && sessionId != null && username != null) {
        emit(
          GetAccountDataSuccess(
            accountId: accountId,
            sessionId: sessionId,
            userName: username,
          ),
        );
      } else {
        emit(GetAccountDataFailed('The data is Null'));
      }
    } catch (e) {
      emit(GetAccountDataFailed(e.toString()));
    }
  }
}
