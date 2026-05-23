import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/food_item.dart';
import '../providers/food_store.dart';
import '../models/app_theme.dart';

class ItemDetailSheet extends StatelessWidget {
  final FoodItem item;

  const ItemDetailSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('dd MMM yyyy');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 20),

          // IMAGE (FIXED - NO EMOJIS)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.backgroundGreen,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: item.imageUrl != null
                ? (item.imageUrl!.startsWith('http')
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(item.imageUrl!),
                        fit: BoxFit.cover,
                      ))
                : const Icon(
                    Icons.fastfood,
                    color: Colors.green,
                    size: 36,
                  ),
          ),

          const SizedBox(height: 16),

          Text(
            item.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            item.category,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 20),

          _InfoRow(label: 'Location', value: item.location),
          _InfoRow(
            label: 'Expires',
            value: fmt.format(item.expiryDate),
          ),
          _InfoRow(
            label: 'Purchased',
            value: fmt.format(item.purchaseDate),
          ),
          _InfoRow(
            label: 'Status',
            value: item.expiryLabel,
            valueColor: item.status == ExpiryStatus.expiringSoon ||
                    item.status == ExpiryStatus.expired
                ? Colors.red
                : Colors.green,
          ),

          const SizedBox(height: 20),

          // QUANTITY CONTROLLER
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quantity: ',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),

              Consumer<FoodStore>(
                builder: (_, store, __) {
                  final current = store.items.firstWhere(
                    (e) => e.id == item.id,
                    orElse: () => item,
                  );

                  return Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            store.updateQuantity(item.id, -1),
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.green,
                        ),
                      ),

                      Text(
                        '${current.quantity}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () =>
                            store.updateQuantity(item.id, 1),
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // DELETE BUTTON
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<FoodStore>().removeItem(item.id);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text(
                'Remove item',
                style: TextStyle(color: Colors.red),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}