import 'package:flutter/material.dart';
import '../models/Cart.dart';

class CartDetailScreen extends StatelessWidget {
  final Cart cart;

  const CartDetailScreen({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cart.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                cart.image_paths[0],
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              cart.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Quantity: ${cart.qty}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '\$${(cart.price * cart.qty).toStringAsFixed(2)}', // Convert double to string with 2 decimal places
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement order placement or other actions
              },
              child: Text('Place Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
