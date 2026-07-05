import 'package:flutter/foundation.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService _service = ProductService();

  // these private fields hold the state
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;

  // getters — the UI reads these, never the private fields
  List<Product> get products => List.unmodifiable(_products);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get isEmpty => !_isLoading && _products.isEmpty;

  // TODO: Implement getProducts()
  // Steps:
  // 1. set _isLoading = true + notifyListeners() and clear _errorMessage
  // 2. call _service.getProducts() and store result in _products
  // 3. catch any exception into _errorMessage
  // 4. always set _isLoading = false + notifyListeners() at the end
  Future<void> getProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _service.getProducts();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  // TODO: Implement addProduct()
  // Steps:
  // 1. call _service.createProduct() and add the returned Product
  // 2. to _products, then call notifyListeners()
  // 3. catch exceptions into _errorMessage + notifyListeners()
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _service.createProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // TODO: Implement updateProduct()
  // Steps:
  // 1. call _service.updateProduct()
  // 2. find the item in _products by id using indexWhere(), replace it and notifyListeners()
  Future<void> updateProduct(Product product) async {
    try {
      await _service.updateProduct(product);
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        _products[index] = product;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // TODO: Implement deleteProduct()
  // Steps:
  // 1. call _service.deleteProduct(id)
  // 2. remove the item from _products using removeWhere(), then notifyListeners()
  Future<void> deleteProduct(String id) async {
    try {
      await _service.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
