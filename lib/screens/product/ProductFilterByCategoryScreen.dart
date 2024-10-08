import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_big_shop/services/CartProvider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../models/Category.dart';
import '../../models/Product.dart';
import '../../utils/Constants.dart';

class ProductFilterByCategoryScreen extends StatefulWidget {
  final String title;
  final Category category;

  const ProductFilterByCategoryScreen({super.key,required this.title,required this.category});

  @override
  State<ProductFilterByCategoryScreen> createState() => _ProductFilterByCategoryScreenState();
}

class _ProductFilterByCategoryScreenState extends State<ProductFilterByCategoryScreen> {
  late List<Product> product = [];

  @override
  void initState(){
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    try{
      final category_id = widget.category.id.toString();
      final response = await http.get(Uri.parse(Constants.BASE_URL+Constants.PRODUCT_FLITER_BY_CATEGORY_ROUTE + category_id));
      if(response.statusCode==200){
        final List<dynamic> data = json.decode(response.body)['data'];
        setState(() {
          product = data.map((brand) =>Product.fromJson(brand)).toList();
        });
      }
      else{
        throw Exception('Failed to load brands'+Constants.BASE_URL+Constants.PRODUCT_FLITER_BY_CATEGORY_ROUTE + category_id);
      }
    }
    catch(e){
      print('Error:$e');
    }
  }
  void navigateToProductScreen(Product selectedCategory){
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context)=>ProductFilterByCategoryScreen(title:selectedCategory.name, category:selectedCategory),
    //   ),
    // );
  }
  Future<void>onRefresh()async{
    await fetchData();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.title),
        actions:[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed:(){
              fetchData();
            },
          ),
        ],
      ),
      body:RefreshIndicator(
        onRefresh: onRefresh,
        child: product.isEmpty
            ?Center(child:CircularProgressIndicator())
            :ListView.builder(
          itemCount: product.length,
          itemBuilder: (context,index){
            return ListTile(
              title:Text(product[index].name),
              onTap: (){
                // navigateToProductScreen(product[index]);
                Map carts ={
                  'product_id' :product[index].id,
                  //'qty':3
                };
                print("product pafe cart contemt ${carts}");
                // cartProvider.addToCart(carts:carts,context:context);
              },
            );
          },
        ),
      ),
    );
  }
}