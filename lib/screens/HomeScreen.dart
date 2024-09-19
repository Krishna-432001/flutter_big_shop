import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../models/Order.dart';
import '../services/OrderService.dart';
import '../services/auth.dart';
import 'AboutScreen.dart';
import 'BrandScreen.dart';

import 'OrderDetialScreen.dart';
import 'cart/CartScreen.dart';
import 'category/CategoryScreen.dart';
import 'LoginScreen.dart';
import 'OrderScreen.dart';
import 'PrivacyPolicyScreen.dart';
import 'product/ProductScreen.dart';
import 'RegisterScreen.dart';
import 'SubCategoryScreen.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();
  File? _image;

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      Provider.of<Auth>(context, listen: false).tryToken(token: token);
      print("Read token: $token");
    } else {
      print("Token is null");
    }
  }

  Future<Order?> fetchOrder() async {
    try {
      // Fetch order data from your server
      final order = await OrderService().fetchOrder();
      return order;
    } catch (e) {
      print("Error fetching order: $e");
      return null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text('Home Screen')),
      drawer: Drawer(
        child: Consumer<Auth>(
          builder: (context, auth, child) {
            if (!auth.authenticated) {
              return ListView(
                children: [
                  ListTile(
                    title: Text('Login'),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(title: 'Login Screen'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Register'),
                    leading: Icon(Icons.app_registration),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(title: 'Register Screen'),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Category'),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CategoryScreen(title: 'Category')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('SubCategory'),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SubCategoryScreen(title: 'SubCategory')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Product'),
                    leading: Icon(Icons.category),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductScreen(title: 'Product')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Brand'),
                    leading: Icon(Icons.branding_watermark),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrandScreen(title: 'Brand')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('About'),
                    leading: Icon(Icons.info),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Aboutscreen()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Privacy Policy'),
                    leading: Icon(Icons.privacy_tip),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PrivacyPolciyScreen()),
                      );
                    },
                  ),
                ],
              );
            } else {
              String name = auth.user?.name ?? 'Guest';
              String email = auth.user?.email ?? 'guest@example.com';
              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(name),
                    accountEmail: Text(email),
                    currentAccountPicture: GestureDetector(
                      onTap: _pickImage, // Pick image when avatar is tapped
                      child: CircleAvatar(
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : NetworkImage('https://via.placeholder.com/150') as ImageProvider,
                        child: _image == null
                            ? Text(
                          name[0],
                          style: TextStyle(fontSize: 30.0),
                        )
                            : null,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Home'),
                    leading: Icon(Icons.home),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Cart'),
                    leading: Icon(Icons.add_shopping_cart),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CartScreen(title: 'Cart')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Order'),
                    leading: Icon(Icons.list),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderScreen(title: 'Order')),
                      );
                    },
                  ),
                  ListTile(
                    title: Text('Order Detail'),
                    leading: Icon(Icons.details),
                    onTap: () async {
                      Navigator.pop(context); // Close the drawer
                      Order? order = await fetchOrder(); // Fetch the order data from server
                      if (order != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailScreen(order: order, title: 'Order Detail'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to fetch order details')),
                        );
                      }
                    },
                  ),
                  ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
