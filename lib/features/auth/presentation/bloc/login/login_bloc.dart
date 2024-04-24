// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:onlineshop_app/features/auth/data/models/login_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDatasource _datasource;
  LoginBloc(
    this._datasource,
  ) : super(LoginInitial()) {
    on<OnLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await _datasource.login(event.email, event.password);
      result.fold(
        (failure) => emit(LoginFailure(message: failure)),
        (data) => emit(LoginLoaded(data: data)),
      );
    });
  }
}
