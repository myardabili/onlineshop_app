import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlineshop_app/features/home/data/models/product_model.dart';
import 'package:onlineshop_app/features/home/presentation/models/product_quantity.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutLoaded(items: [])) {
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
        emit(CheckoutLoaded(items: newItems));
      } else {
        final newitem = ProductQuantity(product: event.item, quantity: 1);
        final newItems = [...currentState.items, newitem];
        emit(CheckoutLoaded(items: newItems));
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
          emit(CheckoutLoaded(items: newItems));
        } else {
          final newItem = item.copyWith(quantity: item.quantity - 1);
          final newItems =
              currentState.items.map((e) => e == item ? newItem : e).toList();
          emit(CheckoutLoaded(items: newItems));
        }
      }
    });
  }
}
