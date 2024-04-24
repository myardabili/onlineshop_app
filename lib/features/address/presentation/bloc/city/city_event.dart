part of 'city_bloc.dart';

sealed class CityEvent extends Equatable {
  const CityEvent();

  @override
  List<Object> get props => [];
}

class OnGetCity extends CityEvent {
  final String provinceId;

  const OnGetCity({required this.provinceId});

  @override
  List<Object> get props => [provinceId];
}
