import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_header.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_items_list.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/empty_cart.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/checkout_section.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/clear_cart_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CartCubit(cartService: CartService())..loadCartData(),
      child: const _CartScreenView(),
    );
  }
}

class _CartScreenView extends StatefulWidget {
  const _CartScreenView();

  @override
  State<_CartScreenView> createState() => _CartScreenViewState();
}

class _CartScreenViewState extends State<_CartScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColorLight,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CartError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error: ${state.message}',
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<CartCubit>().loadCartData(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is CartLoaded) {
                return Column(
                  children: [
                    CartHeader(
                      onBackPressed: () => Navigator.pop(context),
                      onMenuPressed: state.isEmpty
                          ? null
                          : () => _showClearCartDialog(context),
                      showMenu: !state.isEmpty,
                    ),
                    Expanded(
                      child: state.isEmpty
                          ? const EmptyCart()
                          : CartItemsList(
                              cartItems: state.cartItems,
                              onRemoveItem: (itemId) => context
                                  .read<CartCubit>()
                                  .removeItem(cartItemId: itemId),
                              onUpdateQuantity: (itemId, quantity) =>
                                  context.read<CartCubit>().updateItemQuantity(
                                    cartItemId: itemId,
                                    quantity: quantity,
                                  ),
                            ),
                    ),
                    if (!state.isEmpty)
                      CheckoutSection(
                        totalPrice: state.totalPrice,
                        onCheckout: () {},
                      ),
                  ],
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  void _showClearCartDialog(BuildContext context) {
    ClearCartDialog.show(
      context: context,
      onClear: () => context.read<CartCubit>().clearCart(),
    );
  }
}
