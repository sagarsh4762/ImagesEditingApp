import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    required this.images,
    required this.name,
    required this.id,
    required this.price,
  });

  String id;
  String images;
  String name;
  int price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      images: json["images"],
      name: json["name"],
      id: json["id"],
      price: json["price"]);

  Map<String, dynamic> toJson() => {
        "images": images,
        "name": name,
        "id": id,
        "price": price,
      };
}
