part of 'history_order_bloc.dart';

sealed class HistoryOrderEvent extends Equatable {
  const HistoryOrderEvent();

  @override
  List<Object> get props => [];
}

class OnGetHistoryOrder extends HistoryOrderEvent {}
