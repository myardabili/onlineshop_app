part of 'check_payment_status_bloc.dart';

sealed class CheckPaymentStatusEvent extends Equatable {
  const CheckPaymentStatusEvent();

  @override
  List<Object> get props => [];
}

class OnCheckPaymentStatus extends CheckPaymentStatusEvent {
  final int orderId;

  const OnCheckPaymentStatus({required this.orderId});
  @override
  List<Object> get props => [orderId];
}
