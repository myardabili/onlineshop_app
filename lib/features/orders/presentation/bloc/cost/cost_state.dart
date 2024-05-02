part of 'cost_bloc.dart';

sealed class CostState extends Equatable {
  const CostState();

  @override
  List<Object> get props => [];
}

final class CostInitial extends CostState {}

final class CostLoading extends CostState {}

final class CostFailure extends CostState {
  final String message;

  const CostFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CostLoaded extends CostState {
  final CostModel cost;

  const CostLoaded({required this.cost});

  @override
  List<Object> get props => [cost];
}
