part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object> get props => [];
}

final class CheckoutInitial extends CheckoutState {}

final class CheckoutLoading extends CheckoutState {}

final class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CheckoutLoaded extends CheckoutState {
  final List<ProductQuantity> items;

  const CheckoutLoaded({required this.items});

  @override
  List<Object> get props => [items];
}
