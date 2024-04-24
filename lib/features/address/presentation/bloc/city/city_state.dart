part of 'city_bloc.dart';

sealed class CityState extends Equatable {
  const CityState();

  @override
  List<Object> get props => [];
}

final class CityInitial extends CityState {}

final class CityLoading extends CityState {}

final class CityFailure extends CityState {
  final String message;

  const CityFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CityLoaded extends CityState {
  final List<City> cities;

  const CityLoaded({required this.cities});

  @override
  List<Object> get props => [cities];
}
