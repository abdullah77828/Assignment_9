import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  // replace YOUR_ID with the token from crudcrud.com
  static String baseUrl = dotenv.env['BASE_URL']!;
  static String productsEndpoint = '$baseUrl/products';
}
