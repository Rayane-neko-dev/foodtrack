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

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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

                  // Image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: item.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              item.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Center(
                                child: Text(
                                  AppTheme.categoryIcon(item.category),
                                  style: const TextStyle(fontSize: 36),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              AppTheme.categoryIcon(item.category),
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    item.category,
                    style: const TextStyle(
                        color: AppTheme.textGrey, fontSize: 14),
                  ),

                  const SizedBox(height: 20),

                  _InfoRow(label: 'Location', value: item.location),
                  _InfoRow(
                      label: 'Expires',
                      value: fmt.format(item.expiryDate)),
                  _InfoRow(
                      label: 'Purchased',
                      value: fmt.format(item.purchaseDate)),
                  _InfoRow(
                    label: 'Status',
                    value: item.expiryLabel,
                    valueColor: item.status == ExpiryStatus.expiringSoon ||
                            item.status == ExpiryStatus.expired
                        ? AppTheme.expiringSoonRed
                        : AppTheme.primaryGreen,
                  ),

                  const SizedBox(height: 20),

                  // Quantity row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Quantity: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
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
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                              Text(
                                '${current.quantity}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                onPressed: () =>
                                    store.updateQuantity(item.id, 1),
                                icon: const Icon(
                                  Icons.add_circle_outline,
                                  color: AppTheme.primaryGreen,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Delete button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<FoodStore>().removeItem(item.id);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete_outline,
                          color: Colors.red),
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

                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
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
              color: AppTheme.textGrey,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: valueColor ?? AppTheme.textDark,
            ),
          ),
        ],
      ),
    );
  }
}