// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/orders/data/datasources/cost_remote_datasource.dart';
import 'package:onlineshop_app/features/orders/data/models/cost_model.dart';

part 'cost_event.dart';
part 'cost_state.dart';

class CostBloc extends Bloc<CostEvent, CostState> {
  final CostRemoteDatasource _datasource;
  CostBloc(
    this._datasource,
  ) : super(CostInitial()) {
    on<OnGetCost>((event, emit) async {
      emit(CostLoading());
      final result = await _datasource.getCost(
        event.origin,
        event.destination,
        'jne',
      );
      result.fold(
        (failure) => emit(CostFailure(message: failure)),
        (data) => emit(CostLoaded(cost: data)),
      );
    });
  }
}
