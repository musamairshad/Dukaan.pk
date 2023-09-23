import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_learning/features/home/bloc/home_bloc.dart';
import '../../cart/screens/cart.dart';
import '../../wishlist/screens/wishlist.dart';
import 'package:bloc_learning/features/home/screens/product_tile_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const Cart(),
            ),
          );
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const Wishlist(),
            ),
          );
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.maybeOf(context)!.clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item added to the cart."),
            ),
          );
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.maybeOf(context)!.clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Item added to the wishlist."),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              ),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Usama Grocery App'),
                backgroundColor: Colors.teal,
                actions: [
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeWishlistButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(Icons.favorite_border),
                  ),
                  IconButton(
                    onPressed: () {
                      homeBloc.add(
                        HomeCartButtonNavigateEvent(),
                      );
                    },
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                ],
              ),
              body: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductTileWidget(
                    product: successState.products[index],
                    homeBloc: homeBloc,
                  );
                },
                itemCount: successState.products.length,
              ),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}
