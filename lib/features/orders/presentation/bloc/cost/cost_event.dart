part of 'cost_bloc.dart';

sealed class CostEvent extends Equatable {
  const CostEvent();

  @override
  List<Object> get props => [];
}

class OnGetCost extends CostEvent {
  final String origin;
  final String destination;
  final int weight;
  final String courier;

  const OnGetCost({
    required this.origin,
    required this.destination,
    required this.weight,
    required this.courier,
  });

  @override
  List<Object> get props => [
        origin,
        destination,
        weight,
        courier,
      ];
}
