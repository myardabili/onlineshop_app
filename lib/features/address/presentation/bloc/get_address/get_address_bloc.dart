// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/address/data/datasources/address_remote_datasource.dart';

import '../../../data/models/address_model.dart';

part 'get_address_event.dart';
part 'get_address_state.dart';

class GetAddressBloc extends Bloc<GetAddressEvent, GetAddressState> {
  final AddressRemoteDatasource _datasource;
  GetAddressBloc(
    this._datasource,
  ) : super(GetAddressInitial()) {
    on<OnGetAddress>((event, emit) async {
      emit(GetAddressLoading());
      final result = await _datasource.getAddress();
      result.fold(
        (failure) => emit(GetAddressFailure(message: failure)),
        (data) => emit(GetAddressLoaded(address: data.data ?? [])),
      );
    });
  }
}
