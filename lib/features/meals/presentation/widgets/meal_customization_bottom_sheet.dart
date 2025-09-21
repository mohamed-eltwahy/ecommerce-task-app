import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/widgets/app_cached_network_image.dart';
import 'package:ecommerce_app/core/widgets/custom_popup.dart';
import 'package:ecommerce_app/core/services/cart_service.dart';
import 'package:ecommerce_app/features/meals/domain/entities/meal_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealCustomizationBottomSheet extends StatefulWidget {
  final MealEntity meal;
  final Function(
    MealEntity meal,
    Map<String, List<String>> selectedOptions,
    int quantity,
    double totalPrice,
  )
  onAddToCart;

  const MealCustomizationBottomSheet({
    super.key,
    required this.meal,
    required this.onAddToCart,
  });

  static void show({
    required BuildContext context,
    required MealEntity meal,
    required Function(
      MealEntity meal,
      Map<String, List<String>> selectedOptions,
      int quantity,
      double totalPrice,
    )
    onAddToCart,
  }) {
    CustomPopup.appShowModalBottomSheet(
      context: context,
      builder: (context) =>
          MealCustomizationBottomSheet(meal: meal, onAddToCart: onAddToCart),
    );
  }

  @override
  State<MealCustomizationBottomSheet> createState() =>
      _MealCustomizationBottomSheetState();
}

class _MealCustomizationBottomSheetState
    extends State<MealCustomizationBottomSheet> {
  int _quantity = 1;
  final Map<String, List<String>> _selectedOptions = {};
  double _basePrice = 0.0;

  @override
  void initState() {
    super.initState();
    _initializeSelections();
  }

  void _initializeSelections() {
    _basePrice = widget.meal.price;

    for (final option in widget.meal.options) {
      if (option.isRequired && option.isSingle && option.values.isNotEmpty) {
        _selectedOptions[option.id] = [option.values.first.id];
        if (option.isPriceDetermining) {
          _basePrice = option.values.first.price;
        }
      } else {
        _selectedOptions[option.id] = [];
      }
    }
  }

  double get _totalPrice {
    double total = _basePrice * _quantity;

    for (final option in widget.meal.options) {
      if (!option.isPriceDetermining) {
        for (final selectedValueId in _selectedOptions[option.id] ?? []) {
          final value = option.values.firstWhere(
            (v) => v.id == selectedValueId,
          );
          total += value.price * _quantity;
        }
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMealImage(),
                  _buildQuantitySelector(),
                  _buildOptions(),
                  SizedBox(height: 100.h),
                ],
              ),
            ),
          ),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Text(
        widget.meal.name,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMealImage() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      height: 150.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: AppCachedNetworkImage(
          imageUrl: widget.meal.imageUrl,
          height: 150.h,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          Row(
            children: [
              _buildQuantityButton(
                icon: Icons.remove,
                onTap: _quantity > 1 ? () => setState(() => _quantity--) : null,
              ),
              Container(
                width: 50.w,
                height: 40.h,
                alignment: Alignment.center,
                child: Text(
                  _quantity.toString(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColorLight,
                  ),
                ),
              ),
              _buildQuantityButton(
                icon: Icons.add,
                onTap: () => setState(() => _quantity++),
              ),
            ],
          ),
          const Spacer(),

          Text(
            '${_basePrice.toStringAsFixed(2)} \$',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.2),
              AppColors.primary.withValues(alpha: 0.4),
              AppColors.primary,
            ],
          ),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(icon, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.meal.options.length,
      itemBuilder: (context, index) {
        final option = widget.meal.options[index];
        return _buildOptionSection(option);
      },
    );
  }

  Widget _buildOptionSection(MealOptionEntity option) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '${option.name}:',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              if (option.isRequired) ...[
                SizedBox(width: 8.w),
                Spacer(),
                Text(
                  '(required)',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 12.h),
          ...option.values.map((value) => _buildOptionItem(option, value)),
        ],
      ),
    );
  }

  Widget _buildOptionItem(
    MealOptionEntity option,
    MealOptionValueEntity value,
  ) {
    final isSelected = _selectedOptions[option.id]?.contains(value.id) ?? false;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () => _toggleOption(option, value),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!, width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                '\$${value.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 12.w),
              _buildSelectionWidget(option, isSelected),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionWidget(MealOptionEntity option, bool isSelected) {
    if (option.isSingle) {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400]!,
            width: 2.w,
          ),
        ),
        child: isSelected
            ? Container(
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF6366F1),
                ),
              )
            : null,
      );
    } else {
      return Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : Colors.grey[400]!,
            width: 2.w,
          ),
          borderRadius: BorderRadius.circular(4.r),
          color: isSelected ? const Color(0xFF6366F1) : Colors.transparent,
        ),
        child: isSelected
            ? Icon(Icons.check, color: Colors.white, size: 16.sp)
            : null,
      );
    }
  }

  void _toggleOption(MealOptionEntity option, MealOptionValueEntity value) {
    setState(() {
      final currentSelection = _selectedOptions[option.id] ?? [];

      if (option.isSingle) {
        _selectedOptions[option.id] = [value.id];
        if (option.isPriceDetermining) {
          _basePrice = value.price;
        }
      } else {
        if (currentSelection.contains(value.id)) {
          _selectedOptions[option.id] = currentSelection
              .where((id) => id != value.id)
              .toList();
        } else {
          _selectedOptions[option.id] = [...currentSelection, value.id];
        }
      }
    });
  }

  Widget _buildAddToCartButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(color: AppColors.scaffoldColorLight),

      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: _canAddToCart() ? _addToCart : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
              disabledBackgroundColor: Colors.grey[300],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add To Cart',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${_totalPrice.toStringAsFixed(0)} \$',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _canAddToCart() {
    for (final option in widget.meal.options) {
      if (option.isRequired) {
        final selection = _selectedOptions[option.id] ?? [];
        if (selection.isEmpty) return false;
      }
    }
    return true;
  }

  void _addToCart() async {
    try {
      final cartService = CartService();
      await cartService.addMealToCart(
        meal: widget.meal,
        selectedOptions: _selectedOptions,
        quantity: _quantity,
        totalPrice: _totalPrice,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${widget.meal.name} to cart'),
            backgroundColor: AppColors.green,
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      }

      widget.onAddToCart(widget.meal, _selectedOptions, _quantity, _totalPrice);

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add item to cart: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        );
      }
    }
  }
}
