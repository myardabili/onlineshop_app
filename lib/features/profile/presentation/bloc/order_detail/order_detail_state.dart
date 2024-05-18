part of 'order_detail_bloc.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {}

final class OrderDetailLoading extends OrderDetailState {}

final class OrderDetailFailure extends OrderDetailState {
  final String message;

  const OrderDetailFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class OrderDetailLoaded extends OrderDetailState {
  final OrderDetail orderDetail;

  const OrderDetailLoaded({required this.orderDetail});
  @override
  List<Object> get props => [orderDetail];
}
