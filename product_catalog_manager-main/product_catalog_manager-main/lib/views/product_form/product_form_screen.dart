// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../providers/product_provider.dart';

class ProductFormScreen extends StatefulWidget {
  // if product is null → Add mode. If not null → Edit mode
  final Product? product;

  const ProductFormScreen({super.key, this.product});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameCtrl;
  late TextEditingController _priceCtrl;

  bool _isSaving = false;
  // this getter tells which mode you are in
  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    // TODO: Initialize both controllers
    // in edit mode, pre-fill them with widget.product values
    // in add mode, leave them empty (or use '' as default)
    _nameCtrl = TextEditingController(text: widget.product?.name ?? '');
    _priceCtrl = TextEditingController(
      text: widget.product?.price.toString() ?? '',
    );
  }

  @override
  void dispose() {
    // TODO: Dispose both controllers to free memory
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    // TODO:
    // 1. validate the form - return early if invalid
    // 2. set _isSaving = true (disables the button while saving)
    // 3. build a Product from the controller values
    // 4. in edit mode, carry over widget.product!.id
    // 5. call the correct provider method (add or update)
    // 6. after awaiting, check 'if (mounted)' then Navigator.pop()
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);

    final product = Product(
      id: widget.product?.id,
      name: _nameCtrl.text,
      price: double.parse(_priceCtrl.text),
    );
    final provider = context.read<ProductProvider>();
    try {
      if (_isEditing) {
        await provider.updateProduct(product);
      } else {
        await provider.addProduct(product);
      }
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to save product. Check your connection.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: const BackButton(color: Color(0xFF0B2C7C)),
        title: Text(
          _isEditing ? 'Edit Product' : 'Add Product',
          style: TextStyle(
            color: Color(0xFF0B2C7C),
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CATALOG MANAGEMENT',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Color(0xFF444651),
              ),
            ),
            Text(
              _isEditing ? 'Modify Product' : 'Define New Product',
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6.0),
            Container(
              height: 4.0,
              width: 48.0,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 24.0),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildField(
                      label: _isEditing ? 'PRODUCT NAME' : 'Product Name',
                      controller: _nameCtrl,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 24.0),
                    _buildField(
                      label: _isEditing ? 'PRICE' : 'Price',
                      controller: _priceCtrl,
                      isPrice: true,
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        if (double.tryParse(v) == null) return 'Invalid number';
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    if (!_isEditing) _buildInfoBox(theme),
                    if (!_isEditing) const SizedBox(height: 48.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isSaving ? null : _save,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          _isEditing ? 'Save Changes' : 'Save Product',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xff0b2c7c1a)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (_isEditing) ...[
              const SizedBox(height: 20.0),
              _buildEditInfoBox(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPrice = false,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF444651),
          ),
        ),
        const SizedBox(height: 6.0),
        TextFormField(
          controller: controller,
          keyboardType: isPrice
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          cursorColor: Color.fromARGB(255, 77, 78, 84),
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF757682),
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12.0),
            ),
            prefixText: isPrice ? '\$ ' : null,
            fillColor: Color(0xFFE7E8E9),
          ),
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildInfoBox(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: theme.colorScheme.primary),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Ensure product pricing aligns with current regional tax regulations and platform fees.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Color(0xFF444651),
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditInfoBox(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(108, 171, 181, 235),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: theme.colorScheme.primary),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              'Updating product details will synchronize changes across all active inventory dashboards and analytics reports instantly.',
              style: TextStyle(color: Color(0xFF555E7F), fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
