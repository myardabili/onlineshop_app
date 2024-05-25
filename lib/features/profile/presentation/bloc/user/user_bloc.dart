// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/profile/data/datasources/user_remote_datasource.dart';

import '../../../data/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRemoteDatasource _datasource;
  UserBloc(
    this._datasource,
  ) : super(UserInitial()) {
    on<OnGetUser>((event, emit) async {
      emit(UserLoading());
      final result = await _datasource.getUser();
      result.fold(
        (failure) => emit(UserFailure(message: failure)),
        (data) => emit(UserLoaded(user: data)),
      );
    });
  }
}
