import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> cartItems;
  final double totalPrice;
  final int totalItems;

  const CartLoaded({
    required this.cartItems,
    required this.totalPrice,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [cartItems, totalPrice, totalItems];

  bool get isEmpty => cartItems.isEmpty;
}

class CartError extends CartState {
  final String message;

  const CartError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CartItemAdded extends CartState {
  final CartItemModel item;

  const CartItemAdded({required this.item});

  @override
  List<Object?> get props => [item];
}

class CartItemUpdated extends CartState {
  final String itemId;
  final int newQuantity;

  const CartItemUpdated({required this.itemId, required this.newQuantity});

  @override
  List<Object?> get props => [itemId, newQuantity];
}

class CartItemRemoved extends CartState {
  final String itemId;

  const CartItemRemoved({required this.itemId});

  @override
  List<Object?> get props => [itemId];
}

class CartCleared extends CartState {}
