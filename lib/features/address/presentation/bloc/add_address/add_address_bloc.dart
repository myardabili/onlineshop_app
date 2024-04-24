// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/address/data/datasources/address_remote_datasource.dart';
import 'package:onlineshop_app/features/address/data/models/address_request_model.dart';

part 'add_address_event.dart';
part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  final AddressRemoteDatasource _datasource;
  AddAddressBloc(
    this._datasource,
  ) : super(AddAddressInitial()) {
    on<OnAddAddress>((event, emit) async {
      emit(AddAddressLoading());
      final result = await _datasource.addAddress(event.model);
      result.fold(
        (failure) => emit(AddAddressFailure(message: failure)),
        (data) => emit(AddAddressLoaded()),
      );
    });
  }
}
