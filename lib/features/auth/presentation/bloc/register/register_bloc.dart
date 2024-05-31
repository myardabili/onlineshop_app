// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:onlineshop_app/features/auth/data/models/register_model.dart';
import 'package:onlineshop_app/features/auth/data/models/register_request_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource _datasource;
  RegisterBloc(
    this._datasource,
  ) : super(RegisterInitial()) {
    on<OnRegister>((event, emit) async {
      emit(RegisterLoading());
      final result = await _datasource.register(
        event.model,
      );
      result.fold(
        (failure) => emit(RegisterFailure(message: failure)),
        (data) => emit(RegisterLoaded(user: data)),
      );
    });
  }
}
