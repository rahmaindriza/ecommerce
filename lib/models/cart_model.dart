// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  List<Item> items;
  int total;

  Model({
    required this.items,
    required this.total,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total": total,
  };
}

class Item {
  int id;
  String name;
  int quantity;
  int price;

  Item({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "price": price,
  };
}
