import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/login_customer.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginCustomer) : super(const LoginState.initial());

  final LoginCustomer _loginCustomer;

  Future<void> submit({required String phone, required String password}) async {
    emit(const LoginState.submitting());
    final result = await _loginCustomer(phone: phone, password: password);
    result.fold(
      (user) => emit(LoginState.success(user)),
      (exception) => emit(LoginState.failure(exception)),
    );
  }
}
