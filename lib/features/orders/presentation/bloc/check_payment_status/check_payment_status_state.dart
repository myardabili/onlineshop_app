part of 'check_payment_status_bloc.dart';

sealed class CheckPaymentStatusState extends Equatable {
  const CheckPaymentStatusState();

  @override
  List<Object> get props => [];
}

final class CheckPaymentStatusInitial extends CheckPaymentStatusState {}

final class CheckPaymentStatusLoading extends CheckPaymentStatusState {}

final class CheckPaymentStatusFailure extends CheckPaymentStatusState {
  final String message;

  const CheckPaymentStatusFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class CheckPaymentStatusLoaded extends CheckPaymentStatusState {
  final String status;

  const CheckPaymentStatusLoaded({required this.status});
  @override
  List<Object> get props => [status];
}
