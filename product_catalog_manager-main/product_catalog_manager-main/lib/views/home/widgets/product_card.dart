// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Color(0xFF0B2C7C),
              fontWeight: FontWeight.w900,
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 24.0),
          const Divider(),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 6.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        size: 16.0,
                        color: theme.iconTheme.color?.withOpacity(0.7),
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'EDIT',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF444651),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 6.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        size: 16.0,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        'DELETE',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFFBA1A1A),
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
