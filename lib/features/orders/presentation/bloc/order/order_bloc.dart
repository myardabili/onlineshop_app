// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/orders/data/datasources/order_remote_datasource.dart';
import 'package:onlineshop_app/features/orders/data/models/order_request_model.dart';

import '../../../../home/data/models/product_quantity.dart';
import '../../../data/models/order_model.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRemoteDatasource _datasource;
  OrderBloc(
    this._datasource,
  ) : super(OrderInitial()) {
    on<OnOrder>((event, emit) async {
      emit(OrderLoading());
      final orderRequestData = OrderRequestModel(
          addressId: event.addressId,
          paymentMethod: event.paymentMethod,
          shippingService: event.shippingService,
          shippingCost: event.shippingCost,
          paymentVaName: event.paymentVaName,
          subtotal: 0,
          totalCost: 0,
          items: event.products
              .map((e) => Item(productId: e.product.id!, quantity: e.quantity))
              .toList());
      final result = await _datasource.order(orderRequestData);
      result.fold(
        (failure) => emit(OrderFailure(message: failure)),
        (data) => emit(OrderLoaded(orderModel: data)),
      );
    });
  }
}
