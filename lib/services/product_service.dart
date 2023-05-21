import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> listOfProducts = [];
  bool isProductsInitialized = false;
  List<Product> listOfCartProducts = [];

  int get numOfProd => listOfProducts.length;

  void setProductInitializedTrue (bool b){
    isProductsInitialized = b;
  }

  Product getProductById (String id)=> listOfProducts.firstWhere((prod) => prod.id == id,orElse: null);

  Future<List<Product>> fetchProducts() async {
    if(isProductsInitialized)
      return listOfProducts;
    // return [];
    var apiUrl =
        "https://en3hu5n1lk.execute-api.eu-north-1.amazonaws.com/items";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final products = json.decode(response.body) as List<dynamic>;
        listOfProducts = products.map((p) => Product.fromJson(p)).toList();
        return listOfProducts;
      } else
        return [];
    } catch (error) {
      print('Error fetching products: $error');
      return [];
    }
  }

}
