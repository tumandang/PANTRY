import 'package:pantry/models/cartitem.dart';
import 'package:pantry/models/cartmanager.dart';

import 'package:flutter/material.dart';
import 'package:pantry/models/popularfood.dart';
import 'package:provider/provider.dart';

class Homeitem extends StatelessWidget {
  final PopularFood FoodModel;
  const Homeitem({super.key, required this.FoodModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180, // fixed width for horizontal scroll
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IMAGE
            AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                FoodModel.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 8),

            // NAME
            Text(
              FoodModel.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // STOCK
            Text(
              "${FoodModel.count} orders",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            // BUTTON
            ElevatedButton.icon(
              onPressed: () {
                final foodtaken = CartItem(
                  id: FoodModel.id,
                  name: FoodModel.name,
                  category:
                      'Top Pickup', 
                  quantity: 1,
                  stock: FoodModel
                      .count, 
                  imageUrl: FoodModel.image,
                );

                Provider.of<Cartmanager>(
                  context,
                  listen: false,
                ).additem(foodtaken);
              },
              icon: const Icon(Icons.add_shopping_cart_sharp, size: 18),
              label: const Text("Add", style: TextStyle(fontSize: 12)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                foregroundColor: Theme.of(context).colorScheme.surface,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
