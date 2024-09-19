import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Order.dart';

class OrderService {
  Future<Order?> fetchOrder() async {
    final response = await http.get(Uri.parse('https://your-api-endpoint.com/orders/1'));

    if (response.statusCode == 200) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load order');
    }
  }
}
