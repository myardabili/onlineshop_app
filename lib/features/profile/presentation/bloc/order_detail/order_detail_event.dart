part of 'order_detail_bloc.dart';

sealed class OrderDetailEvent extends Equatable {
  const OrderDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetOrderDetail extends OrderDetailEvent {
  final int orderId;

  const OnGetOrderDetail({required this.orderId});
  @override
  List<Object> get props => [orderId];
}
