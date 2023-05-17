import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts() async {
  var apiUrl = "https://en3hu5n1lk.execute-api.eu-north-1.amazonaws.com/items";
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      final products = json.decode(response.body) as List<dynamic>;
      return products;

    }
    else
      return [];
  } catch (error) {
    print('Error fetching products: $error');
    return [];
  }
}
