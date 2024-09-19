class SubCategory{
  int id;
  String name;
  // String description;
  // String buying_price;
  // String selling_price;
  // String measurment_unit;
  // String eraned_profit;
  // String company;
  // String status;
  // String image_path;
  // String current_qty;
  // String reorder_level;

  SubCategory({
    required this.id,
    required this.name,
    // required this.description,
    // required this.buying_price,
    // required this.selling_price,
    // required this.measurment_unit,
    // required this.eraned_profit,
    // required this.company,
    // required this.status,
    // required this.image_path,
    // required this.current_qty,
    // required this.reorder_level,
  });
  SubCategory.fromJson(Map<String,dynamic>json):
        id=json['id'],
        name=json['name'];
        // image_path=json['image_path'],
        // description=json['description'],
        // buying_price=json['buying_price'],
        // selling_price=json['selling_price'],
        // measurment_unit=json['measurment_unit'],
        // eraned_profit=json['eraned_profit'],
        // company=json['company'],
        // status=json['status'],
        // current_qty=json['current_qty'],
        // reorder_level=json['reorder_level'];
}