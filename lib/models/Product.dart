class Product{
  int id;
  String name;
  List<String> image_paths;
  String price;
  // String category_id;
  // String brand_id;
  //
  // String qty;
  //  String alert_stock;
  // String description;
  // String product_label_id;
  // String product_tag_id;
  // String stock_status;
  // String is_featured;
  // String min_order_qty;
  // String max_order_qty;



  Product({
    required this.id,
    required this.name,
    required this.image_paths,
    required this.price,
    // required this.category_id,
    // required this.brand_id,
    // required this.description,
    // required this.qty,
    // required this.alert_stock,

    // required this.product_label_id,
    // required this.product_tag_id,
    // required this.stock_status,
    // required this.is_featured,
    // required this.min_order_qty,
    // required this.max_order_qty,



  });

  Product.fromJson(Map<String,dynamic>json):
        id=json['id'],
        name=json['name'],
        image_paths = List<String>.from(json['image_path']),
        price=json['price'];
        // category_id=json['category_id'];
        // brand_id=json['brand_id'],
        //
        // qty=json['qty'],
        // alert_stock=json['alert_stock'],
        // description=json['description'];
        // product_label_id=json['product_label_id'],
        // product_tag_id=json['product_tag_id'],
        // stock_status=json['stock_status'],
        // is_featured=json['is_featured'],
        // min_order_qty=json['min_order_qty'],
        // max_order_qty=json['max_order_qty'];


}