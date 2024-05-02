part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderFailure extends OrderState {
  final String message;

  const OrderFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class OrderLoaded extends OrderState {
  final OrderModel orderModel;

  const OrderLoaded({required this.orderModel});
  @override
  List<Object> get props => [orderModel];
}
