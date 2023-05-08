

class Product {
  final int price;
  final String id;
  final String name;

  Product({
    required this.price,
    required this.id,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      price: json['price'] as int,
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'price': price,
      'id': id,
      'name': name,
    };
  }
}
