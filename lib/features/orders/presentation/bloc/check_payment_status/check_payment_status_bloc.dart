import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/orders/data/datasources/order_remote_datasource.dart';

part 'check_payment_status_event.dart';
part 'check_payment_status_state.dart';

class CheckPaymentStatusBloc
    extends Bloc<CheckPaymentStatusEvent, CheckPaymentStatusState> {
  final OrderRemoteDatasource _datasource;
  CheckPaymentStatusBloc(this._datasource)
      : super(CheckPaymentStatusInitial()) {
    on<OnCheckPaymentStatus>((event, emit) async {
      emit(CheckPaymentStatusLoading());
      final result = await _datasource.checkPaymentStatus(event.orderId);
      result.fold(
        (failure) => emit(CheckPaymentStatusFailure(message: failure)),
        (data) => emit(CheckPaymentStatusLoaded(status: data)),
      );
    });
  }
}
