import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts() async {
  var apiUrl = "YOUR_API_HERE";
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
    rethrow;
  }
}
