part of 'tracking_bloc.dart';

sealed class TrackingEvent extends Equatable {
  const TrackingEvent();

  @override
  List<Object> get props => [];
}

class OnGetTracking extends TrackingEvent {
  final String waybill;
  final String courier;

  const OnGetTracking({required this.waybill, required this.courier});
  @override
  List<Object> get props => [waybill, courier];
}
