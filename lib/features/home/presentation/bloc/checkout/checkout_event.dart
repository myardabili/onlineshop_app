part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends CheckoutEvent {
  final Product item;

  const AddItem({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CheckoutEvent {
  final Product item;

  const RemoveItem({required this.item});

  @override
  List<Object> get props => [item];
}
