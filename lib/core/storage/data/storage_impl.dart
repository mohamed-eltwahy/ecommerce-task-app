import 'package:ecommerce_app/core/storage/data/storage.dart';
import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:hive/hive.dart';

class StorageImpl implements Storage {
  final Box<String> stringBox;
  final Box<bool> boolBox;
  final Box<CartItemModel> cartBox;
  // final Box<UserModel> userBox;

  // static const String _user = "user";
  static const String _token = "token";
  static const String _language = "language";
  static const String _onboarding = "onboarding";

  StorageImpl({
    required this.stringBox,
    required this.boolBox,
    required this.cartBox,
  });

  //* user storage
  // @override
  // Future<void> storeUserData({required UserModel user}) async {await userBox.put(_user, user);}

  // @override
  // UserModel? getUserData() => userBox.get(_user);

  // @override
  // Future<void> deleteUserData() async {await userBox.delete(_user);}

  //* token storage
  @override
  Future<void> storeToken({required String token}) async {
    await stringBox.put(_token, token);
  }

  @override
  String? getToken() => stringBox.get(_token);

  @override
  Future<void> deleteToken() async {
    await stringBox.delete(_token);
  }

  //* onboarding storage
  @override
  bool isOnboardingCompleted() => boolBox.get(_onboarding) ?? false;

  @override
  Future<void> storeOnboardingCompleted({
    required bool isOnboardingCompleted,
  }) async {
    await boolBox.put(_onboarding, isOnboardingCompleted);
  }

  //* language storage
  @override
  Future<void> storeLang({required String langCode}) async {
    await stringBox.put(_language, langCode);
  }

  @override
  String getLang() => stringBox.get(_language) ?? "en";

  @override
  Future<void> deleteLang() async {
    await stringBox.delete(_language);
  }

  //* check token
  @override
  bool isAuthorized() => stringBox.get(_token) != null;

  //* check language
  @override
  bool isSelectLang() => stringBox.get(_language) != null;

  //* cart storage
  @override
  Future<void> addToCart({required CartItemModel cartItem}) async {
    // Check if item with same meal and options already exists
    final existingItem = _findExistingCartItem(
      mealId: cartItem.mealId,
      selectedOptions: cartItem.selectedOptions,
    );

    if (existingItem != null) {
      // Update quantity of existing item
      final newQuantity = existingItem.quantity + cartItem.quantity;
      final pricePerUnit = existingItem.totalPrice / existingItem.quantity;
      final updatedItem = existingItem.copyWith(
        quantity: newQuantity,
        totalPrice: pricePerUnit * newQuantity,
      );
      await cartBox.put(existingItem.id, updatedItem);
    } else {
      // Add new item to cart
      await cartBox.put(cartItem.id, cartItem);
    }
  }

  @override
  Future<void> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    final cartItem = cartBox.get(cartItemId);
    if (cartItem != null) {
      if (quantity <= 0) {
        await removeFromCart(cartItemId: cartItemId);
      } else {
        // Calculate total price including base price and selected options
        final totalPrice = _calculateItemTotalPrice(cartItem, quantity);
        final updatedItem = cartItem.copyWith(
          quantity: quantity,
          totalPrice: totalPrice,
        );
        await cartBox.put(cartItemId, updatedItem);
      }
    }
  }

  @override
  Future<void> removeFromCart({required String cartItemId}) async {
    await cartBox.delete(cartItemId);
  }

  @override
  Future<void> clearCart() async {
    await cartBox.clear();
  }

  @override
  List<CartItemModel> getCartItems() {
    return cartBox.values.toList();
  }

  @override
  int getCartItemsCount() {
    return cartBox.values.fold(0, (total, item) => total + item.quantity);
  }

  @override
  double getCartTotalPrice() {
    return cartBox.values.fold(0.0, (total, item) => total + item.totalPrice);
  }

  @override
  bool isCartEmpty() {
    return cartBox.isEmpty;
  }

  // Helper method to find existing cart item with same meal and options
  CartItemModel? _findExistingCartItem({
    required String mealId,
    required Map<String, List<String>> selectedOptions,
  }) {
    for (final item in cartBox.values) {
      if (item.mealId == mealId &&
          _optionsMatch(item.selectedOptions, selectedOptions)) {
        return item;
      }
    }
    return null;
  }

  // Helper method to calculate total price for a cart item
  double _calculateItemTotalPrice(CartItemModel cartItem, int quantity) {
    // Calculate the price per unit (base price + options)
    final pricePerUnit = cartItem.totalPrice / cartItem.quantity;

    // Return the new total price
    return pricePerUnit * quantity;
  }

  // Helper method to compare options
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
