// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlineshop_app/features/profile/data/datasources/history_order_remote_datasource.dart';
import 'package:onlineshop_app/features/profile/data/models/tracking_model.dart';

part 'tracking_event.dart';
part 'tracking_state.dart';

class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  final HistoryOrderRemoteDatasource _datasource;
  TrackingBloc(
    this._datasource,
  ) : super(TrackingInitial()) {
    on<OnGetTracking>((event, emit) async {
      emit(TrackingLoading());
      final result = await _datasource.getWaybill(event.waybill, event.courier);
      result.fold(
        (failure) => emit(TrackingFailure(message: failure)),
        (data) => emit(TrackingLoaded(tracking: data)),
      );
    });
  }
}
