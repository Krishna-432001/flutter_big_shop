import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import the toast package for showing messages
import '../models/Order.dart'; // Ensure this is the correct path to your Order model

class OrderDetailScreen extends StatefulWidget {
  final String title;
  final Order order; // Add the order parameter

  const OrderDetailScreen({
    super.key,
    required this.title,
    required this.order,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  void placeOrder(BuildContext context) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Order'),
          content: Text('Are you sure you want to place this order?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await Future.delayed(Duration(seconds: 2)); // Simulate network delay

      Navigator.of(context).pop(); // Close the progress dialog

      Fluttertoast.showToast(
        msg: "Order placed successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order; // Access the order from the widget

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // Use widget.title for the AppBar title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                order.image_Path, // Correct the imagePath property
                fit: BoxFit.cover,
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              order.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Quantity: ${order.qty}',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              '\$${order.price.toStringAsFixed(2)}', // Convert double to string with 2 decimal places
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () => placeOrder(context),
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
