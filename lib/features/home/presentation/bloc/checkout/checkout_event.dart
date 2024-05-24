// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object> get props => [];
}

class Started extends CheckoutEvent {}

class AddItem extends CheckoutEvent {
  final Data item;

  const AddItem({required this.item});

  @override
  List<Object> get props => [item];
}

class RemoveItem extends CheckoutEvent {
  final Data item;

  const RemoveItem({required this.item});

  @override
  List<Object> get props => [item];
}

class AddAddressId extends CheckoutEvent {
  final int addressId;
  const AddAddressId({required this.addressId});

  @override
  List<Object> get props => [addressId];
}

class AddPaymentMethod extends CheckoutEvent {
  final String paymentMethod;

  const AddPaymentMethod({required this.paymentMethod});

  @override
  List<Object> get props => [paymentMethod];
}

class AddShippingService extends CheckoutEvent {
  final String shippingService;
  final int shippingCost;

  const AddShippingService({
    required this.shippingService,
    required this.shippingCost,
  });

  @override
  List<Object> get props => [shippingService, shippingCost];
}
