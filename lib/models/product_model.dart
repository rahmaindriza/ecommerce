class ProductModel {
  int id;
  String name;
  int price;
  String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'] ?? '', // 🔥 NULL SAFE
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'price': price,
    'description': description,
  };
}
