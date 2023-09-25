import 'package:bloc_learning/features/wishlist/screens/wishlist_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_learning/features/wishlist/bloc/wishlist_bloc.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  final WishlistBloc wishlistBloc = WishlistBloc();
  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        title: const Text('Wishlist Items'),
        centerTitle: true,
      ),
      body: BlocConsumer<WishlistBloc, WishlistState>(
        bloc: wishlistBloc,
        listener: (context, state) {
          if (state is HomeProductItemRemoveFromWishlistActionState) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Item is removed from the wishlist."),
              ),
            );
          }
        },
        listenWhen: (previous, current) => current is WishlistActionState,
        buildWhen: (previous, current) => current is! WishlistActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishlistSuccessState:
              final successState = state as WishlistSuccessState;
              return successState.wishlistItems.isEmpty
                  ? const Center(
                      child: Text(
                        'Wishlist is empty.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) {
                        return WishlistTileWidget(
                          product: successState.wishlistItems[index],
                          wishlistBloc: wishlistBloc,
                        );
                      },
                      itemCount: successState.wishlistItems.length,
                    );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
