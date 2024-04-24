part of 'subdistrict_bloc.dart';

sealed class SubdistrictState extends Equatable {
  const SubdistrictState();

  @override
  List<Object> get props => [];
}

final class SubdistrictInitial extends SubdistrictState {}

final class SubdistrictLoading extends SubdistrictState {}

final class SubdistrictFailure extends SubdistrictState {
  final String message;

  const SubdistrictFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SubdistrictLoaded extends SubdistrictState {
  final List<Subdistrict> subdistricts;

  const SubdistrictLoaded({required this.subdistricts});

  @override
  List<Object> get props => [subdistricts];
}
