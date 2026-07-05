class Product {
  final String? id; // nullable: 'null' during creation, assigned by API
  final String name;
  final double price;

  Product({this.id, required this.name, required this.price});

  // build a Product from the JSON map crudcrud returns
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] as String?,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );
  }

  // convert to JSON for POST/PUT requests
  // do NOT include the _id field
  Map<String, dynamic> toJson() => {'name': name, 'price': price};
}
