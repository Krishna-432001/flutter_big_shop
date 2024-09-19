import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/Product.dart';
import '../../services/CartProvider.dart';
import '../OrderDetialScreen.dart';
import '../OrderScreen.dart';


class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  Future<void> placeOrder(BuildContext context) async {
    // Add product to cart
    Provider.of<CartProvider>(context, listen: false).addToCart(
      cart: {
        'product_id': product.id,
        'product_name': product.name,
        'qty': 1,
      },
      context: context,
    );

    // Navigate to OrderScreen with the new order details
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderScreen(title: 'Order Details'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image_paths[0],
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false).addToCart(
                      cart: {
                        'product_id': product.id,
                        'product_name': product.name,
                        'qty': 1,
                      },
                      context: context,
                    );
                  },
                  child: Text('Add to Cart'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () => placeOrder(context),
                  child: Text('Place Order'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
