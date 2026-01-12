// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) =>
    CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  List<Item> items;

  CartModel({
    required this.items,
  });

  // Total otomatis dihitung dari items
  int get total =>
      items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    items: List<Item>.from(
        json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String id;
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
    id: json["id"].toString(),
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
