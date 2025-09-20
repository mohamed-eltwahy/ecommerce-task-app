class MealEntity {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double? priceBeforeDiscount;
  final List<MealOptionEntity> options;

  MealEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    this.priceBeforeDiscount,
    required this.options,
  });
}

class MealOptionEntity {
  final String id;
  final String name;
  final bool isRequired;
  final bool isSingle;
  final bool isPriceDetermining;
  final List<MealOptionValueEntity> values;

  MealOptionEntity({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.isSingle,
    required this.isPriceDetermining,
    required this.values,
  });
}

class MealOptionValueEntity {
  final String id;
  final String name;
  final double price;

  MealOptionValueEntity({
    required this.id,
    required this.name,
    required this.price,
  });
}
