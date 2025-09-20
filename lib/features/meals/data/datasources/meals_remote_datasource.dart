import '../models/meal_model.dart';

abstract class MealsRemoteDataSource {
  Future<List<MealModel>> getMeals();
}

class MealsRemoteDataSourceImpl implements MealsRemoteDataSource {
  @override
  Future<List<MealModel>> getMeals() async {
  
    final sampleData = {
      "meals": [
        {
          "id": "meal_001",
          "name": "Grilled Salmon",
          "description":
              "Char-grilled Atlantic salmon fillet with lemon, garlic and roasted potatoes.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/8/8a/Grilled_salmon.jpg",
          "price": 18.5333333333333,
          "price_before_discount": 25,
          "options": [
            {
              "id": "opt_001",
              "name": "Side",
              "is_required": true,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_001", "name": "Roasted Potatoes", "price": 0},
                {"id": "val_002", "name": "Steamed Vegetables", "price": 0},
                {"id": "val_003", "name": "Mixed Greens Salad", "price": 0},
              ],
            },
            {
              "id": "opt_002",
              "name": "Sauce",
              "is_required": false,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_004", "name": "Lemon Butter", "price": 0},
                {"id": "val_005", "name": "Garlic Herb Butter", "price": 0.5},
                {"id": "val_006", "name": "Dill Cream", "price": 0.75},
              ],
            },
            {
              "id": "opt_003",
              "name": "Add Extra Shrimp",
              "is_required": false,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_008", "name": "6 Shrimp", "price": 5},
                {"id": "val_009", "name": "10 Shrimp", "price": 8.5},
              ],
            },
          ],
        },
        {
          "id": "meal_002",
          "name": "Grilled Lobster Tail",
          "description":
              "Succulent lobster tail grilled and brushed with garlic-herb butter.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/7/77/Four_cooked_lobster_tails.jpg",
          "price": 34.2166666666667,
          "price_before_discount": 40,
          "options": [
            {
              "id": "opt_004",
              "name": "Butter Style",
              "is_required": true,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_010", "name": "Regular Butter", "price": 0},
                {"id": "val_011", "name": "Garlic Butter", "price": 1.5},
                {"id": "val_012", "name": "Herbed Butter", "price": 2},
              ],
            },
            {
              "id": "opt_005",
              "name": "Side",
              "is_required": false,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_013", "name": "Steamed Veggies", "price": 0},
                {"id": "val_014", "name": "Garlic Mashed Potatoes", "price": 0},
                {"id": "val_015", "name": "Caesar Salad", "price": 0},
              ],
            },
          ],
        },
        {
          "id": "meal_003",
          "name": "Fried Calamari",
          "description":
              "Crispy battered calamari rings served with your choice of dipping sauce.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/3/34/Fried_calamari.jpg",
          "price": 0,
          "options": [
            {
              "id": "opt_006",
              "name": "Size",
              "is_required": true,
              "is_single": true,
              "is_price_determining": true,
              "values": [
                {"id": "val_016", "name": "Regular", "price": 12},
                {"id": "val_017", "name": "Large", "price": 16},
              ],
            },
            {
              "id": "opt_007",
              "name": "Dip",
              "is_required": true,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_018", "name": "Marinara", "price": 0},
                {"id": "val_019", "name": "Spicy Aioli", "price": 0.5},
                {"id": "val_020", "name": "Tartar", "price": 0},
              ],
            },
          ],
        },
        {
          "id": "meal_004",
          "name": "Seafood Fra Diavolo",
          "description":
              "Spicy tomato-based pasta tossed with shrimp, mussels, garlic and chili — classic Fra Diavolo.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/5/50/Shrimp_pasta.jpg",
          "price": 0,
          "options": [
            {
              "id": "opt_008",
              "name": "Pasta Type",
              "is_required": true,
              "is_single": true,
              "is_price_determining": true,
              "values": [
                {"id": "val_021", "name": "Linguine", "price": 15},
                {"id": "val_022", "name": "Spaghetti", "price": 17},
                {"id": "val_023", "name": "Gluten-free", "price": 23},
              ],
            },
            {
              "id": "opt_009",
              "name": "Heat Level",
              "is_required": true,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_024", "name": "Mild", "price": 0},
                {"id": "val_025", "name": "Medium", "price": 0},
                {"id": "val_026", "name": "Hot", "price": 0},
              ],
            },
          ],
        },
        {
          "id": "meal_005",
          "name": "Lemon Garlic Parmesan Shrimp Pasta",
          "description":
              "Bright lemon and garlic pasta tossed with shrimp and finished with Parmesan.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/d/db/Shrimp_Scampi_Linguine_%2818893300233%29.jpg",
          "price": 15,
          "price_before_discount": null,
          "options": [
            {
              "id": "opt_010",
              "name": "Protein Upgrade",
              "is_required": false,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_027", "name": "Shrimp (included)", "price": 0},
                {"id": "val_028", "name": "Add Scallops", "price": 4.5},
                {"id": "val_029", "name": "Add Chicken", "price": 3},
              ],
            },
            {
              "id": "opt_011",
              "name": "Extra Parmesan",
              "is_required": false,
              "is_single": true,
              "is_price_determining": false,
              "values": [
                {"id": "val_030", "name": "No", "price": 0},
                {"id": "val_031", "name": "Yes (+\$0.50)", "price": 0.5},
              ],
            },
          ],
        },
        {
          "id": "meal_006",
          "name": "Creamy Shrimp Alfredo",
          "description":
              "Rich fettuccine Alfredo tossed with sautéed shrimp and a creamy Parmesan sauce.",
          "image_url":
              "https://upload.wikimedia.org/wikipedia/commons/6/6f/Creamy_Mozzarella_Shrimp_Pasta.jpg",
          "price": 0,
          "options": [
            {
              "id": "opt_012",
              "name": "Pasta",
              "is_required": true,
              "is_single": true,
              "is_price_determining": true,
              "values": [
                {"id": "val_032", "name": "Fettuccine", "price": 14.75},
                {"id": "val_033", "name": "Penne", "price": 16.75},
                {"id": "val_034", "name": "Gluten-free", "price": 23},
              ],
            },
            {
              "id": "opt_013",
              "name": "Add-Ins",
              "is_required": false,
              "is_single": false,
              "is_price_determining": false,
              "values": [
                {"id": "val_035", "name": "Broccoli", "price": 0.75},
                {"id": "val_036", "name": "Mushrooms", "price": 0.75},
                {"id": "val_037", "name": "Extra Shrimp (6)", "price": 5},
              ],
            },
          ],
        },
      ],
    };

    final meals = (sampleData['meals'] as List<dynamic>)
        .map((meal) => MealModel.fromJson(meal as Map<String, dynamic>))
        .toList();

    return meals;
  }
}
