import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String mealId;

  @HiveField(2)
  final String mealName;

  @HiveField(3)
  final String mealImageUrl;

  @HiveField(4)
  final double basePrice;

  @HiveField(5)
  final int quantity;

  @HiveField(6)
  final double totalPrice;

  @HiveField(7)
  final Map<String, List<String>> selectedOptions;

  @HiveField(8)
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.basePrice,
    required this.quantity,
    required this.totalPrice,
    required this.selectedOptions,
    required this.addedAt,
  });

  // Create a unique cart item ID based on meal and options
  static String generateCartItemId({
    required String mealId,
    required Map<String, List<String>> selectedOptions,
  }) {
    final optionsString = selectedOptions.entries
        .map((e) => '${e.key}:${e.value.join(',')}')
        .join('|');
    return '${mealId}_${optionsString.hashCode}';
  }

  // Convert to JSON for API calls if needed
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_id': mealId,
      'meal_name': mealName,
      'meal_image_url': mealImageUrl,
      'base_price': basePrice,
      'quantity': quantity,
      'total_price': totalPrice,
      'selected_options': selectedOptions,
      'added_at': addedAt.toIso8601String(),
    };
  }

  // Create a copy with updated quantity
  CartItemModel copyWith({
    String? id,
    String? mealId,
    String? mealName,
    String? mealImageUrl,
    double? basePrice,
    int? quantity,
    double? totalPrice,
    Map<String, List<String>>? selectedOptions,
    DateTime? addedAt,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      mealId: mealId ?? this.mealId,
      mealName: mealName ?? this.mealName,
      mealImageUrl: mealImageUrl ?? this.mealImageUrl,
      basePrice: basePrice ?? this.basePrice,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartItemModel &&
        other.id == id &&
        other.mealId == mealId &&
        other.mealName == mealName &&
        other.mealImageUrl == mealImageUrl &&
        other.basePrice == basePrice &&
        other.quantity == quantity &&
        other.totalPrice == totalPrice &&
        _mapEquals(other.selectedOptions, selectedOptions);
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      mealId,
      mealName,
      mealImageUrl,
      basePrice,
      quantity,
      totalPrice,
      selectedOptions,
    );
  }

  bool _mapEquals(Map<String, List<String>>? a, Map<String, List<String>>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || !_listEquals(a[key], b[key])) return false;
    }
    return true;
  }

  bool _listEquals(List<String>? a, List<String>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
