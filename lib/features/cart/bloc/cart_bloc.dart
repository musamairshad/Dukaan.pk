import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/cart_items.dart';
import 'package:bloc_learning/features/home/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(
      CartSuccessState(cartItems: cartItems),
    );
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.product);
    emit(CartSuccessState(cartItems: cartItems));
    // emit one more state which is a actionable state for scaffold message.
  }
}
