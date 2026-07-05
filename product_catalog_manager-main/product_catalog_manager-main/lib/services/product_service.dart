import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core/constants/api_constants.dart';
import '../models/product.dart';

class ProductService {
  final String _endpoint = ApiConstants.productsEndpoint;

  // TODO: Send a GET request to _endpoint
  // check statusCode == 200 and decode body as a List
  // map each item through Product.fromJson()
  // on failure: throw an Exception with the status code
  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch products: ${response.statusCode}');
    }
  }

  // TODO: Send a POST request to _endpoint
  // set header 'Content-Type: application/json'
  // body = jsonEncode(product.toJson())
  // crudcrud returns 201 on success + the new object in the body
  Future<Product> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create product: ${response.statusCode}');
    }
  }

  // TODO: Send a PUT request to _endpoint + '/' + product.id
  // use same headers and body structure as createProduct
  // crudcrud returns 200 with an empty body on success
  Future<void> updateProduct(Product product) async {
    final response = await http.put(
      Uri.parse('$_endpoint/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product: ${response.statusCode}');
    }
  }

  // TODO: Send a DELETE request to _endpoint + '/' + id
  // no body needed. Throw if statusCode != 200
  Future<void> deleteProduct(String id) async {
    final response = await http.delete(Uri.parse('$_endpoint/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product: ${response.statusCode}');
    }
  }
}
