class Category{
  int id;
  String name;
  // String description;
  // String buying_price;
  // String selling_price;
  // String excepted_profit;
  // String eraned_profit;
  // String company;
  // String status;
  // String image_path;

  Category({
    required this.id,
    required this.name,
    // required this.description,
    // required this.buying_price,
    // required this.selling_price,
    // required this.excepted_profit,
    // required this.eraned_profit,
    // required this.company,
    // required this.status,
    // required this.image_path
  });
  Category.fromJson(Map<String,dynamic>json):
        id=json['id'],
        name=json['name'];
        // image_path=json['image_path'],
        // description=json['description'],
        // buying_price=json['buying_price'],
        // selling_price=json['selling_price'],
        // excepted_profit=json['excepted_profit'],
        // eraned_profit=json['eraned_profit'],
        // company=json['company'],
        // status=json['status'];
}