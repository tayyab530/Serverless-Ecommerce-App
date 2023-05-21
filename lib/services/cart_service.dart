import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/models/product.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import 'auth_service.dart';

class CartProvider with ChangeNotifier {
  Cart cart = Cart(id: "1", listOfProducts: [], uId: userId);
  bool isCartsInitialized = false;

  int get numOfProd => cart.listOfProducts.length;

  double get totalCartPrice => !isCartEmpty ?
      cart.listOfProducts.map((p) => p.price).toList().reduce((a, b) => a + b) : 0.0;

  bool get isCartEmpty => numOfProd == 0;

  double get tax => totalCartPrice * 0.1;

  double get shipping => !isCartEmpty ? 4.99 : 0.0;

  double get grandTotalCartPrice {
    var total = totalCartPrice;
    var grandTotal = total + tax + shipping;
    return grandTotal;
  }

  void addProductToCart(Product prod) {
    cart.listOfProducts.add(prod);
  }

  Future<http.Response> postCart() async {
    var apiUrl =
        "https://fboj2w6j2f.execute-api.eu-north-1.amazonaws.com/carts";
    try {
      var headers = {
        "Content-Type": "application/json",
      };
      cart.uId = userId;
      var j = cart.toJson();
      var body = jsonEncode(j);

      // body.addAll({"uId": userId});
      final response =
          await http.put(Uri.parse(apiUrl), body: body, headers: headers);
      final res = json.decode(response.body);
      print(res);
      return response;
    } catch (error) {
      var err = 'Error posting cart: $error';
      print(err);
      return http.Response("Error while posting cart!", 400);
    }
  }

  String getNextId() {
    return (int.parse(cart.id) + 1).toString();
  }

  void clearCart() {
    cart = Cart(id: getNextId(), listOfProducts: [], uId: userId);
  }
}
