import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final CartService _cartService;

  CartCubit({required CartService cartService})
    : _cartService = cartService,
      super(CartInitial());

  Future<void> loadCartData() async {
    try {
      emit(CartLoading());

      final cartItems = _cartService.getCartItems();
      final totalPrice = _cartService.getCartTotalPrice();
      final totalItems = _cartService.getCartItemsCount();

      emit(
        CartLoaded(
          cartItems: cartItems,
          totalPrice: totalPrice,
          totalItems: totalItems,
        ),
      );
    } catch (e) {
      emit(CartError(message: 'Failed to load cart data: $e'));
    }
  }

  Future<void> addItemToCart({required CartItemModel cartItem}) async {
    try {
      await _cartService.addMealToCart(
        meal: _cartItemToMealEntity(cartItem),
        selectedOptions: cartItem.selectedOptions,
        quantity: cartItem.quantity,
        totalPrice: cartItem.totalPrice,
      );

      emit(CartItemAdded(item: cartItem));
      await loadCartData();
    } catch (e) {
      emit(CartError(message: 'Failed to add item to cart: $e'));
    }
  }

  Future<void> updateItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      if (quantity <= 0) {
        await removeItem(cartItemId: cartItemId);
        return;
      }

      await _cartService.updateCartItemQuantity(
        cartItemId: cartItemId,
        quantity: quantity,
      );

      emit(CartItemUpdated(itemId: cartItemId, newQuantity: quantity));
      await loadCartData();
    } catch (e) {
      emit(CartError(message: 'Failed to update item quantity: $e'));
    }
  }

  Future<void> removeItem({required String cartItemId}) async {
    try {
      await _cartService.removeFromCart(cartItemId: cartItemId);

      emit(CartItemRemoved(itemId: cartItemId));
      await loadCartData();
    } catch (e) {
      emit(CartError(message: 'Failed to remove item from cart: $e'));
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartService.clearCart();

      emit(CartCleared());
      await loadCartData();
    } catch (e) {
      emit(CartError(message: 'Failed to clear cart: $e'));
    }
  }

  List<CartItemModel> getCurrentCartItems() {
    if (state is CartLoaded) {
      return (state as CartLoaded).cartItems;
    }
    return [];
  }

  double getCurrentTotalPrice() {
    if (state is CartLoaded) {
      return (state as CartLoaded).totalPrice;
    }
    return 0.0;
  }

  int getCurrentTotalItems() {
    if (state is CartLoaded) {
      return (state as CartLoaded).totalItems;
    }
    return 0;
  }

  bool isCartEmpty() {
    if (state is CartLoaded) {
      return (state as CartLoaded).isEmpty;
    }
    return true;
  }

  Future<void> increaseItemQuantity(String cartItemId) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final item = currentState.cartItems.firstWhere(
        (item) => item.id == cartItemId,
        orElse: () => throw Exception('Item not found'),
      );
      await updateItemQuantity(
        cartItemId: cartItemId,
        quantity: item.quantity + 1,
      );
    }
  }

  Future<void> decreaseItemQuantity(String cartItemId) async {
    final currentState = state;
    if (currentState is CartLoaded) {
      final item = currentState.cartItems.firstWhere(
        (item) => item.id == cartItemId,
        orElse: () => throw Exception('Item not found'),
      );

      if (item.quantity > 1) {
        await updateItemQuantity(
          cartItemId: cartItemId,
          quantity: item.quantity - 1,
        );
      } else {
        await removeItem(cartItemId: cartItemId);
      }
    }
  }

  CartItemModel? getCartItemById(String cartItemId) {
    final currentState = state;
    if (currentState is CartLoaded) {
      try {
        return currentState.cartItems.firstWhere(
          (item) => item.id == cartItemId,
        );
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  bool canDecreaseItemQuantity(String cartItemId) {
    final item = getCartItemById(cartItemId);
    return item != null && item.quantity > 1;
  }

  dynamic _cartItemToMealEntity(CartItemModel cartItem) {
    return {
      'id': cartItem.mealId,
      'name': cartItem.mealName,
      'imageUrl': cartItem.mealImageUrl,
      'price': cartItem.basePrice,
    };
  }
}
