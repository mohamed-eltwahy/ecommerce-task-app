import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/features/cart/presentation/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartIcon extends StatefulWidget {
  final Color? iconColor;
  final Color? badgeColor;
  final double? iconSize;

  const CartIcon({super.key, this.iconColor, this.badgeColor, this.iconSize});

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  final CartService _cartService = CartService();
  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _loadCartCount();
  }

  void _loadCartCount() {
    setState(() {
      _cartCount = _cartService.getCartItemsCount();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            ).then((_) {
              // Refresh cart count when returning from cart screen
              _loadCartCount();
            });
          },
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: widget.iconColor ?? Colors.white,
            size: widget.iconSize ?? 24.sp,
          ),
        ),
        if (_cartCount > 0)
          Positioned(
            right: 8.w,
            top: 8.h,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: widget.badgeColor ?? Colors.red,
                borderRadius: BorderRadius.circular(10.r),
              ),
              constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.h),
              child: Text(
                _cartCount > 99 ? '99+' : _cartCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
