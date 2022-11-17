class Product {
  int? id;
  String? name;
  String? price;

  Product({
    this.id,
    this.name,
    this.price,
  });

  factory Product.fromMap(Map<dynamic, dynamic> json) {
    return Product(
      id: json['shopid'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'shopid': id,
      'name': name,
      'price': price,
    };
  }
}
