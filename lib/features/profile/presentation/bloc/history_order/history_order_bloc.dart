// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/profile/data/datasources/history_order_remote_datasource.dart';

import '../../../data/models/history_order_model.dart';

part 'history_order_event.dart';
part 'history_order_state.dart';

class HistoryOrderBloc extends Bloc<HistoryOrderEvent, HistoryOrderState> {
  final HistoryOrderRemoteDatasource _datasource;
  HistoryOrderBloc(
    this._datasource,
  ) : super(HistoryOrderInitial()) {
    on<OnGetHistoryOrder>((event, emit) async {
      emit(HistoryOrderLoading());
      final result = await _datasource.getOrders();
      result.fold(
        (failure) => emit(HistoryOrderFailure(message: failure)),
        (data) => emit(HistoryOrderLoaded(orders: data)),
      );
    });
  }
}
