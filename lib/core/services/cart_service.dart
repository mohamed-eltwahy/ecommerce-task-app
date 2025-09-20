import 'package:ecommerce_app/core/storage/data/storage.dart';
import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:ecommerce_app/features/meals/domain/entities/meal_entity.dart';
import 'package:get_it/get_it.dart';

class CartService {
  final Storage _storage = GetIt.instance<Storage>();

  Future<void> addMealToCart({
    required MealEntity meal,
    required Map<String, List<String>> selectedOptions,
    required int quantity,
    required double totalPrice,
  }) async {
    final selectedOptionsWithNames = _convertOptionIdsToNames(
      meal,
      selectedOptions,
    );

    // Calculate the actual total price including options
    final calculatedTotalPrice = _calculateTotalPriceWithOptions(
      meal,
      selectedOptions,
      quantity,
    );

    final cartItemId = CartItemModel.generateCartItemId(
      mealId: meal.id,
      selectedOptions: selectedOptions,
    );

    final cartItem = CartItemModel(
      id: cartItemId,
      mealId: meal.id,
      mealName: meal.name,
      mealImageUrl: meal.imageUrl,
      basePrice: meal.price,
      quantity: quantity,
      totalPrice: calculatedTotalPrice,
      selectedOptions: selectedOptionsWithNames,
      addedAt: DateTime.now(),
    );

    await _storage.addToCart(cartItem: cartItem);
  }

  List<CartItemModel> getCartItems() {
    return _storage.getCartItems();
  }

  int getCartItemsCount() {
    return _storage.getCartItemsCount();
  }

  double getCartTotalPrice() {
    return _storage.getCartTotalPrice();
  }

  bool isCartEmpty() {
    return _storage.isCartEmpty();
  }

  Future<void> updateCartItemQuantity({
    required String cartItemId,
    required int quantity,
  }) async {
    await _storage.updateCartItem(cartItemId: cartItemId, quantity: quantity);
  }

  Future<void> removeFromCart({required String cartItemId}) async {
    await _storage.removeFromCart(cartItemId: cartItemId);
  }

  Future<void> clearCart() async {
    await _storage.clearCart();
  }

  CartItemModel? getCartItemById(String cartItemId) {
    final cartItems = getCartItems();
    try {
      return cartItems.firstWhere((item) => item.id == cartItemId);
    } catch (e) {
      return null;
    }
  }

  bool isMealInCart({
    required String mealId,
    required Map<String, List<String>> selectedOptions,
  }) {
    final cartItems = getCartItems();
    return cartItems.any(
      (item) =>
          item.mealId == mealId &&
          _optionsMatch(item.selectedOptions, selectedOptions),
    );
  }

  int getMealQuantityInCart({
    required String mealId,
    required Map<String, List<String>> selectedOptions,
  }) {
    final cartItems = getCartItems();
    final matchingItem = cartItems.firstWhere(
      (item) =>
          item.mealId == mealId &&
          _optionsMatch(item.selectedOptions, selectedOptions),
      orElse: () => throw StateError('Item not found'),
    );
    return matchingItem.quantity;
  }

  /// Calculate total price including base price and selected options
  double _calculateTotalPriceWithOptions(
    MealEntity meal,
    Map<String, List<String>> selectedOptions,
    int quantity,
  ) {
    double totalPrice = meal.price * quantity;

    // Add prices for selected options
    for (final entry in selectedOptions.entries) {
      final optionId = entry.key;
      final selectedValueIds = entry.value;

      // Find the option in meal options
      final option = meal.options.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () => throw Exception('Option not found: $optionId'),
      );

      // Add price for each selected value
      for (final valueId in selectedValueIds) {
        final value = option.values.firstWhere(
          (val) => val.id == valueId,
          orElse: () => throw Exception('Value not found: $valueId'),
        );
        totalPrice += value.price * quantity;
      }
    }

    return totalPrice;
  }

  Map<String, List<String>> _convertOptionIdsToNames(
    MealEntity meal,
    Map<String, List<String>> selectedOptions,
  ) {
    final Map<String, List<String>> optionsWithNames = {};

    for (final entry in selectedOptions.entries) {
      final optionId = entry.key;
      final selectedValueIds = entry.value;

      final option = meal.options.firstWhere(
        (opt) => opt.id == optionId,
        orElse: () => throw Exception('Option not found: $optionId'),
      );

      final List<String> valueNames = [];
      for (final valueId in selectedValueIds) {
        final value = option.values.firstWhere(
          (val) => val.id == valueId,
          orElse: () => throw Exception('Value not found: $valueId'),
        );
        valueNames.add(value.name);
      }

      optionsWithNames[option.name] = valueNames;
    }

    return optionsWithNames;
  }

  bool _optionsMatch(
    Map<String, List<String>> options1,
    Map<String, List<String>> options2,
  ) {
    if (options1.length != options2.length) return false;

    for (final key in options1.keys) {
      if (!options2.containsKey(key)) return false;
      final list1 = options1[key]!..sort();
      final list2 = options2[key]!..sort();
      if (list1.length != list2.length) return false;
      for (int i = 0; i < list1.length; i++) {
        if (list1[i] != list2[i]) return false;
      }
    }
    return true;
  }
}
