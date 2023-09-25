import 'package:flutter/material.dart';
import 'package:bloc_learning/features/cart/screens/cart_tile_widget.dart';
import 'package:bloc_learning/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text('Cart Items'),
        centerTitle: true,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          if (state is HomeProductItemRemoveFromCartActionState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Item is removed from the cart."),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return successState.cartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Cart is empty.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return CartTileWidget(
                          product: successState.cartItems[index],
                          cartBloc: cartBloc,
                        );
                      },
                      itemCount: successState.cartItems.length,
                    );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
