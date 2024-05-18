part of 'history_order_bloc.dart';

sealed class HistoryOrderState extends Equatable {
  const HistoryOrderState();

  @override
  List<Object> get props => [];
}

final class HistoryOrderInitial extends HistoryOrderState {}

final class HistoryOrderLoading extends HistoryOrderState {}

final class HistoryOrderFailure extends HistoryOrderState {
  final String message;

  const HistoryOrderFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class HistoryOrderLoaded extends HistoryOrderState {
  final HistoryOrderModel orders;

  const HistoryOrderLoaded({required this.orders});
  @override
  List<Object> get props => [orders];
}
