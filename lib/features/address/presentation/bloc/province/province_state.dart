part of 'province_bloc.dart';

sealed class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

final class ProvinceInitial extends ProvinceState {}

final class ProvinceLoading extends ProvinceState {}

final class ProvinceFailure extends ProvinceState {
  final String message;

  const ProvinceFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class ProvinceLoaded extends ProvinceState {
  final List<Province> provinces;

  const ProvinceLoaded({required this.provinces});

  @override
  List<Object> get props => [provinces];
}
