import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:ecommerce_app/core/models/cart_item_model.dart';
import 'package:ecommerce_app/core/widgets/app_cached_network_image.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:ecommerce_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback? onDecreaseQuantity;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onIncreaseQuantity,
    this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return _buildCard(context, state);
      },
    );
  }

  Widget _buildCard(BuildContext context, CartState state) {
    if (state is CartItemRemoved && state.itemId == item.id) {
      return const SizedBox.shrink();
    }

    CartItemModel currentItem = item;
    if (state is CartLoaded) {
      final updatedItem = state.cartItems.firstWhere(
        (cartItem) => cartItem.id == item.id,
        orElse: () => item,
      );
      currentItem = updatedItem;
    }

    final isLoading = state is CartLoading;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.cardColorLight,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(context),
            SizedBox(width: 12.w),
            _buildDetailsSection(currentItem),
            _buildQuantitySection(context, currentItem, isLoading),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 140.w,
          height: 140.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: Colors.grey[100],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppCachedNetworkImage(
              imageUrl: item.mealImageUrl,
              width: 140.w,
              height: 140.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4.h,
          left: 4.w,
          child: GestureDetector(
            onTap: () {
              context.read<CartCubit>().removeItem(cartItemId: item.id);
              onRemove();
            },
            child: Container(
              width: 35.w,
              height: 35.h,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete, color: Colors.white, size: 25.sp),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection(CartItemModel currentItem) {
    return Expanded(
      child: SizedBox(
        height: 140.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentItem.mealName,
              style: TextStyles.textViewBold16.copyWith(
                color: AppColors.textColorLight,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            if (_hasNonEmptyOptions(currentItem)) ...[
              SizedBox(height: 8.h),
              _buildCustomizationDetails(currentItem),
            ],

            const Spacer(),

            Text(
              '${currentItem.totalPrice.toStringAsFixed(0)} \$',
              style: TextStyles.textViewBold16.copyWith(
                color: AppColors.textColorLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasNonEmptyOptions(CartItemModel currentItem) {
    return currentItem.selectedOptions.entries.any(
      (entry) => entry.value.isNotEmpty,
    );
  }

  Widget _buildCustomizationDetails(CartItemModel currentItem) {
    final nonEmptyOptions = currentItem.selectedOptions.entries
        .where((entry) => entry.value.isNotEmpty)
        .toList();

    if (nonEmptyOptions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nonEmptyOptions
          .map((entry) => _buildOptionRow(entry.key, entry.value.join(', ')))
          .toList(),
    );
  }

  Widget _buildOptionRow(String label, String value) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyles.textViewBold12.copyWith(
              color: AppColors.textColorLight,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.textViewRegular12.copyWith(
                color: AppColors.greyTextColorLight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection(
    BuildContext context,
    CartItemModel currentItem,
    bool isLoading,
  ) {
    return Column(
      children: [
        _buildQuantityButton(
          context: context,
          icon: Icons.add,
          onTap: isLoading
              ? null
              : () {
                  context.read<CartCubit>().increaseItemQuantity(
                    currentItem.id,
                  );
                  onIncreaseQuantity();
                },
        ),
        SizedBox(height: 8.h),
        Text(
          currentItem.quantity.toString(),
          style: TextStyles.textViewBold16.copyWith(
            color: AppColors.textColorLight,
          ),
        ),
        SizedBox(height: 8.h),
        _buildQuantityButton(
          context: context,
          icon: Icons.remove,
          onTap: isLoading
              ? null
              : () {
                  context.read<CartCubit>().decreaseItemQuantity(
                    currentItem.id,
                  );
                  onDecreaseQuantity?.call();
                },
        ),
      ],
    );
  }

  Widget _buildQuantityButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28.w,
        height: 28.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.primary.withValues(alpha: 0.2),
              AppColors.primary.withValues(alpha: 0.4),
              AppColors.primary,
            ],
          ),
          color: onTap != null ? AppColors.primary : Colors.grey[300],
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: onTap != null ? Colors.white : Colors.grey[600],
          size: 20.sp,
        ),
      ),
    );
  }
}
