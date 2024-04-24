// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/address/data/datasources/rajaongkir_remore_datasource.dart';

import '../../../data/models/city_model.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final RajaongkirRemoteDatasource _datasource;
  CityBloc(
    this._datasource,
  ) : super(CityInitial()) {
    on<OnGetCity>((event, emit) async {
      emit(CityLoading());
      final result = await _datasource.getCity(event.provinceId);
      result.fold(
        (failure) => emit(CityFailure(message: failure)),
        (data) => emit(CityLoaded(cities: data.rajaongkir?.results ?? [])),
      );
    });
  }
}
