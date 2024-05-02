part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OnOrder extends OrderEvent {
  final int addressId;
  final String paymentMethod;
  final String shippingService;
  final int shippingCost;
  final String paymentVaName;
  final List<ProductQuantity> products;

  const OnOrder({
    required this.addressId,
    required this.paymentMethod,
    required this.shippingService,
    required this.shippingCost,
    required this.paymentVaName,
    required this.products,
  });

  @override
  List<Object> get props => [
        addressId,
        paymentMethod,
        shippingService,
        shippingCost,
        paymentVaName,
        products,
      ];
}
