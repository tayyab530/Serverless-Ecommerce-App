import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_ui_kit/services/cart_service.dart';
import 'package:flutter_ecommerce_ui_kit/services/product_service.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class Products extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String,String> args = (ModalRoute.of(context)!.settings.arguments) as Map<String,String>;
    final imageUrl = args!["url"];
    final productId = args!["pId"];
    final prvProd = Provider.of<ProductProvider>(context,listen: false);
    final product = prvProd.getProductById(productId!);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                width: double.infinity,
                  height: 260,
                  child: Hero(
                    tag: imageUrl!,
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imageUrl.toString(),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            product.name,
                            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    '\$${product.price}',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Text(
                                    '\$${(product.price + product.price * 0.1).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.black,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough
                                    )
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                RatingStars(
                                  value: 5,
                                  starSize: 16,
                                  valueLabelColor: Colors.amber,
                                  starColor: Colors.amber,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment(-1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                    'Description',
                                  style: TextStyle(color: Colors.black, fontSize: 20,  fontWeight: FontWeight.w600),
                                ),
                              )
                          ),
                          Container(
                              alignment: Alignment(-1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. but also the leap into electronic typesetting Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 50, bottom: 10),
                            child: ButtonTheme(
                              buttonColor: Theme.of(context).primaryColor,
                              minWidth: double.infinity,
                              height: 40.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  var prodPrv = Provider.of<ProductProvider>(context,listen: false);
                                  var cartPrv = Provider.of<CartProvider>(context,listen: false);

                                  var prod = prodPrv.getProductById(productId!);
                                  cartPrv.addProductToCart(prod);
                                  print("Cart Products: " + cartPrv.cart.listOfProducts.toString());

                                  var snackBar = SnackBar(content: Text("Added to the Cart"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                child: Text(
                                  "Add to Cart",
                                  style: TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

      ),
    );
  }
}
