import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:ecommerce_app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemsList extends StatefulWidget {
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
  State<CartItemsList> createState() => _CartItemsListState();
}

class _CartItemsListState extends State<CartItemsList>
    with TickerProviderStateMixin {
  late List<AnimationController> _itemAnimationControllers;
  late List<Animation<double>> _itemAnimations;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  @override
  void didUpdateWidget(CartItemsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    
    if (oldWidget.cartItems.length != widget.cartItems.length) {
      _disposeAnimations();
      _initializeAnimations();
      _startAnimations();
    }
  }

  void _initializeAnimations() {
    _itemAnimationControllers = List.generate(
      widget.cartItems.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 600),
        vsync: this,
      ),
    );

    _itemAnimations = _itemAnimationControllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    }).toList();

    _slideAnimations = _itemAnimationControllers.map((controller) {
      return Tween<Offset>(
        begin: const Offset(1.0, 0.0), 
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic),
      );
    }).toList();
  }

  void _startAnimations() {
    
    for (int i = 0; i < _itemAnimationControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 150 * i), () {
        if (mounted) {
          _itemAnimationControllers[i].forward();
        }
      });
    }
  }

  void _disposeAnimations() {
    for (var controller in _itemAnimationControllers) {
      controller.dispose();
    }
  }

  @override
  void dispose() {
    _disposeAnimations();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: widget.cartItems.length,
      itemBuilder: (context, index) {
        final item = widget.cartItems[index];

        
        if (index >= _itemAnimationControllers.length) {
          return CartItemCard(
            item: item,
            onRemove: () => widget.onRemoveItem(item.id),
            onIncreaseQuantity: () =>
                widget.onUpdateQuantity(item.id, item.quantity + 1),
            onDecreaseQuantity: item.quantity > 1
                ? () => widget.onUpdateQuantity(item.id, item.quantity - 1)
                : null,
          );
        }

        return AnimatedBuilder(
          animation: _itemAnimations[index],
          builder: (context, child) {
            return SlideTransition(
              position: _slideAnimations[index],
              child: Transform.scale(
                scale: _itemAnimations[index].value,
                child: Opacity(
                  opacity: _itemAnimations[index].value.clamp(0.0, 1.0),
                  child: CartItemCard(
                    item: item,
                    onRemove: () => widget.onRemoveItem(item.id),
                    onIncreaseQuantity: () =>
                        widget.onUpdateQuantity(item.id, item.quantity + 1),
                    onDecreaseQuantity: item.quantity > 1
                        ? () => widget.onUpdateQuantity(
                            item.id,
                            item.quantity - 1,
                          )
                        : null,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
