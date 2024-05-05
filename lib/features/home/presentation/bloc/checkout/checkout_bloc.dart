import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/home/data/models/product_model.dart';
import 'package:onlineshop_app/features/home/data/models/product_quantity.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutLoaded([], 0, '', '', 0, '')) {
    on<AddItem>((event, emit) {
      final currentState = state as CheckoutLoaded;
      if (currentState.items
          .any((element) => element.product.id == event.item.id)) {
        final index = currentState.items
            .indexWhere((element) => element.product.id == event.item.id);
        final item = currentState.items[index];
        final newItem = item.copyWith(quantity: item.quantity + 1);
        final newItems =
            currentState.items.map((e) => e == item ? newItem : e).toList();
        emit(CheckoutLoaded(
          newItems,
          currentState.addressId,
          currentState.paymentMethod,
          currentState.shippingService,
          currentState.shippingCost,
          currentState.paymentVaName,
        ));
      } else {
        final newitem = ProductQuantity(product: event.item, quantity: 1);
        final newItems = [...currentState.items, newitem];
        emit(CheckoutLoaded(
          newItems,
          currentState.addressId,
          currentState.paymentMethod,
          currentState.shippingService,
          currentState.shippingCost,
          currentState.paymentVaName,
        ));
      }
    });

    on<RemoveItem>((event, emit) {
      final currentState = state as CheckoutLoaded;
      if (currentState.items
          .any((element) => element.product.id == event.item.id)) {
        final index = currentState.items
            .indexWhere((element) => element.product.id == event.item.id);
        final item = currentState.items[index];
        if (item.quantity == 1) {
          final newItems = currentState.items
              .where((element) => element.product.id != event.item.id)
              .toList();
          emit(CheckoutLoaded(
            newItems,
            currentState.addressId,
            currentState.paymentMethod,
            currentState.shippingService,
            currentState.shippingCost,
            currentState.shippingService,
          ));
        } else {
          final newItem = item.copyWith(quantity: item.quantity - 1);
          final newItems =
              currentState.items.map((e) => e == item ? newItem : e).toList();
          emit(CheckoutLoaded(
            newItems,
            currentState.addressId,
            currentState.paymentMethod,
            currentState.shippingService,
            currentState.shippingCost,
            currentState.shippingService,
          ));
        }
      }
    });

    on<AddAddressId>((event, emit) {
      final currentState = state as CheckoutLoaded;
      emit(CheckoutLoaded(
        currentState.items,
        event.addressId,
        currentState.paymentMethod,
        currentState.shippingService,
        currentState.shippingCost,
        currentState.shippingService,
      ));
    });

    on<AddPaymentMethod>((event, emit) {
      final currentState = state as CheckoutLoaded;
      emit(CheckoutLoaded(
        currentState.items,
        currentState.addressId,
        'bank_transfer',
        currentState.shippingService,
        currentState.shippingCost,
        event.paymentMethod,
      ));
    });

    on<AddShippingService>((event, emit) {
      final currentState = state as CheckoutLoaded;
      emit(CheckoutLoaded(
        currentState.items,
        currentState.addressId,
        currentState.paymentMethod,
        event.shippingService,
        event.shippingCost,
        currentState.paymentMethod,
      ));
    });

    on<Started>(((event, emit) {
      emit(const CheckoutLoaded([], 0, '', '', 0, ''));
    }));
  }
}
