class MealModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double? priceBeforeDiscount;
  final List<MealOptionModel> options;

  MealModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.priceBeforeDiscount,
    required this.options,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      price: (json['price'] as num).toDouble(),
      priceBeforeDiscount: json['price_before_discount'] != null
          ? (json['price_before_discount'] as num).toDouble()
          : null,
      options: (json['options'] as List<dynamic>)
          .map(
            (option) =>
                MealOptionModel.fromJson(option as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'price_before_discount': priceBeforeDiscount,
      'options': options.map((option) => option.toJson()).toList(),
    };
  }
}

class MealOptionModel {
  final String id;
  final String name;
  final bool isRequired;
  final bool isSingle;
  final bool isPriceDetermining;
  final List<MealOptionValueModel> values;

  MealOptionModel({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.isSingle,
    required this.isPriceDetermining,
    required this.values,
  });

  factory MealOptionModel.fromJson(Map<String, dynamic> json) {
    return MealOptionModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isRequired: json['is_required'] as bool,
      isSingle: json['is_single'] as bool,
      isPriceDetermining: json['is_price_determining'] as bool,
      values: (json['values'] as List<dynamic>)
          .map(
            (value) =>
                MealOptionValueModel.fromJson(value as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_required': isRequired,
      'is_single': isSingle,
      'is_price_determining': isPriceDetermining,
      'values': values.map((value) => value.toJson()).toList(),
    };
  }
}

class MealOptionValueModel {
  final String id;
  final String name;
  final double price;

  MealOptionValueModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory MealOptionValueModel.fromJson(Map<String, dynamic> json) {
    return MealOptionValueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price};
  }
}
