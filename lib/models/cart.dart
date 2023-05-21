import 'product.dart';

class Cart {
  String id;
  List<Product> listOfProducts;
  String uId;

  Cart({required this.id, required this.listOfProducts,required this.uId});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      listOfProducts: (json['listOfProducts'] as List)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
        uId:json['uId']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'listOfProducts': listOfProducts.map((product) => product.id).toList(),
      "uId": uId,
    };
  }
}

