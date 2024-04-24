// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/address/data/datasources/rajaongkir_remore_datasource.dart';

import '../../../data/models/subdistrict_model.dart';

part 'subdistrict_event.dart';
part 'subdistrict_state.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  final RajaongkirRemoteDatasource _datasource;
  SubdistrictBloc(
    this._datasource,
  ) : super(SubdistrictInitial()) {
    on<OnGetSubdistrict>((event, emit) async {
      emit(SubdistrictLoading());
      final result = await _datasource.getSubdistrict(event.cityId);
      result.fold(
        (failure) => emit(SubdistrictFailure(message: failure)),
        (data) => emit(
            SubdistrictLoaded(subdistricts: data.rajaongkir?.results ?? [])),
      );
    });
  }
}
