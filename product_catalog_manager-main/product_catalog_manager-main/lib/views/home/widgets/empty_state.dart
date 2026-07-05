// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final VoidCallback onAdd;

  const EmptyState({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 192.0,
              width: 192.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 70.0,
                color: theme.colorScheme.primary.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 47.0),
            Text(
              'No products found',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.75,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Your workspace is currently a clean slate. Start by adding your first product to the repository.',
              style: TextStyle(fontSize: 16.0, color: Color(0xFF444651)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40.0),
            ElevatedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              label: const Text(
                'Add Product',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
