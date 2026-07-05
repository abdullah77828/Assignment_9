// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/product_provider.dart';
import '../product_form/product_form_screen.dart';
import 'widgets/empty_state.dart';
import 'widgets/error_state.dart';
import 'widgets/loading_state.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // TODO: Call getProducts() on the provider here
    // use context.read() and not context.watch() in initState
    // wrap the call in Future.microtask(() => ...), so the widget is fully mounted before context
    Future.microtask(() {
      context.read<ProductProvider>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      // TODO: Wrap the body in a Consumer<ProductProvider>
      // inside the builder, check these states in order:
      // 1. provider.isLoading → return LoadingState()
      // 2. provider.hasError → return an error widget
      // 3. provider.isEmpty → return EmptyState()
      // 4. otherwise → return a ListView of ProductCards
      body: Consumer<ProductProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const LoadingState();
          }
          if (provider.hasError) {
            return ErrorState(
              message: 'Unable to fetch products. Please try again.',
              onRetry: provider.getProducts,
            );
          }
          if (provider.isEmpty) {
            return EmptyState(onAdd: _openAddProduct);
          }

          return RefreshIndicator(
            onRefresh: provider.getProducts,
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 40.0, bottom: 90.0),
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: provider.products.length,
              itemBuilder: (context, index) {
                final product = provider.products[index];

                return ProductCard(
                  product: product,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormScreen(product: product),
                      ),
                    );
                  },
                  onDelete: () => _confirmDelete(product.id!),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child:
            (!provider.isLoading &&
                !provider.hasError &&
                provider.products.isNotEmpty)
            ? ElevatedButton.icon(
                onPressed: _openAddProduct,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text(
                  'ADD PRODUCT',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              )
            : null,
      ),
    );
  }

  void _openAddProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductFormScreen()),
    );
  }

  void _confirmDelete(String id) {
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Delete Product',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: theme.textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () {
              context.read<ProductProvider>().deleteProduct(id);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}
