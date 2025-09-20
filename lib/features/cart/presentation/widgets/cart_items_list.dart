import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final Function(String) onRemoveItem;
  final Function(String, int) onUpdateQuantity;

  const CartItemsList({
    super.key,
    required this.cartItems,
    required this.onRemoveItem,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return CartItemCard(
          item: item,
          onRemove: () => onRemoveItem(item.id),
          onIncreaseQuantity: () =>
              onUpdateQuantity(item.id, item.quantity + 1),
          onDecreaseQuantity: item.quantity > 1
              ? () => onUpdateQuantity(item.id, item.quantity - 1)
              : null,
        );
      },
    );
  }
}
