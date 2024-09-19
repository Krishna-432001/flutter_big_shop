class Cart {
  int id;
  int product_id;
  String name;
  int qty;
  double price;
  List<String> image_paths;

  Cart({
    required this.id,
    required this.product_id,
    required this.name,
    required this.qty,
    required this.price,
    required this.image_paths,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        product_id = json['product_id'],
        name = json['name'],
        qty = json['qty'],
        price = double.parse(json['price']),
        image_paths = List<String>.from(json['image_path']);
}
