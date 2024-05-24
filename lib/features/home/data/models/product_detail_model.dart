import 'dart:convert';

class ProductDetailModel {
  final String? message;
  final Data? data;

  ProductDetailModel({
    this.message,
    this.data,
  });

  factory ProductDetailModel.fromJson(String str) =>
      ProductDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductDetailModel.fromMap(Map<String, dynamic> json) =>
      ProductDetailModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "message": message,
        "data": data?.toMap(),
      };
}

class Data {
  final int? id;
  final int? categoryId;
  final String? name;
  final String? description;
  final String? image;
  final int? price;
  final int? stock;
  final int? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.categoryId,
    this.name,
    this.description,
    this.image,
    this.price,
    this.stock,
    this.isAvailable,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(String str) => Data.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Data.fromMap(Map<String, dynamic> json) => Data(
        id: json["id"],
        categoryId: json["category_id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        stock: json["stock"],
        isAvailable: json["is_available"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "stock": stock,
        "is_available": isAvailable,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
