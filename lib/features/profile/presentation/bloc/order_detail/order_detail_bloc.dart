// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/profile/data/datasources/history_order_remote_datasource.dart';
import 'package:onlineshop_app/features/profile/data/models/order_detail_model.dart';

part 'order_detail_event.dart';
part 'order_detail_state.dart';

class OrderDetailBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  final HistoryOrderRemoteDatasource _datasource;
  OrderDetailBloc(
    this._datasource,
  ) : super(OrderDetailInitial()) {
    on<OnGetOrderDetail>((event, emit) async {
      emit(OrderDetailLoading());
      final result = await _datasource.getOrderById(event.orderId);
      result.fold(
        (failure) => emit(OrderDetailFailure(message: failure)),
        (data) => emit(OrderDetailLoaded(orderDetail: data.order!)),
      );
    });
  }
}
