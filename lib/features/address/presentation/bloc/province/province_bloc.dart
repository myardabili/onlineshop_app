// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/address/data/datasources/rajaongkir_remore_datasource.dart';

import '../../../data/models/province_model.dart';

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final RajaongkirRemoteDatasource _datasource;
  ProvinceBloc(
    this._datasource,
  ) : super(ProvinceInitial()) {
    on<OnGetProvince>((event, emit) async {
      emit(ProvinceLoading());
      final result = await _datasource.getProvince();
      result.fold(
        (failure) => emit(ProvinceFailure(message: failure)),
        (data) =>
            emit(ProvinceLoaded(provinces: data.rajaongkir?.results ?? [])),
      );
    });
  }
}
