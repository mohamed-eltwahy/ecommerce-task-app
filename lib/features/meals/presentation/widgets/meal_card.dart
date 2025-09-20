import 'package:flutter/material.dart';
import '../../domain/entities/meal_entity.dart';

class MealCard extends StatelessWidget {
  final MealEntity meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              meal.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 200,
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        meal.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (meal.priceBeforeDiscount != null)
                          Text(
                            '\$${meal.priceBeforeDiscount!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          '\$${meal.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Description
                Text(
                  meal.description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                const SizedBox(height: 12),

                // Options count
                if (meal.options.isNotEmpty)
                  Text(
                    '${meal.options.length} customization option${meal.options.length > 1 ? 's' : ''} available',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                const SizedBox(height: 16),

                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
