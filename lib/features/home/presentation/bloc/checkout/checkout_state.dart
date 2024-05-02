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
  final int addressId;
  final String paymentMethod;
  final String shippingService;
  final int shippingCost;
  final String paymentVaName;

  const CheckoutLoaded(
    this.items,
    this.addressId,
    this.paymentMethod,
    this.shippingService,
    this.shippingCost,
    this.paymentVaName,
  );

  @override
  List<Object> get props => [
        items,
        addressId,
        paymentMethod,
        shippingService,
        shippingCost,
        paymentVaName,
      ];
}
