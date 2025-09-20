import 'package:flutter/material.dart';
import '../../domain/entities/meal_entity.dart';

class MealOptionWidget extends StatelessWidget {
  final MealOptionEntity option;
  final String? selectedValueId;
  final Function(String) onValueChanged;

  const MealOptionWidget({
    super.key,
    required this.option,
    this.selectedValueId,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Option title with required indicator
          Row(
            children: [
              Text(
                option.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (option.isRequired) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Required',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 12),

          // Option values
          if (option.isSingle)
            // Radio buttons for single selection
            ...option.values.map(
              (value) => RadioListTile<String>(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    if (value.price > 0)
                      Text(
                        '+\$${value.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
                value: value.id,
              
                contentPadding: EdgeInsets.zero,
              ),
            )
          else
            ...option.values.map(
              (value) => CheckboxListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    if (value.price > 0)
                      Text(
                        '+\$${value.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
                value: selectedValueId == value.id,
                onChanged: (bool? isChecked) {
                  if (isChecked == true) {
                    onValueChanged(value.id);
                  } else {
                    onValueChanged(''); // Clear selection
                  }
                },
                contentPadding: EdgeInsets.zero,
              ),
            ),
        ],
      ),
    );
  }
}
