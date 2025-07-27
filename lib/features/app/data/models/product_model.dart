// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
  json.decode(str).map((x) => ProductModel.fromJson(x)),
);

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int? id;
  String? title;
  String? description;
  // String? category;
  double? price;
  // double? discountPercentage;
  double? rating;
  // int? stock;
  List<String>? tags;
  String? returnPolicy;
  String? thumbnail;
  // int? minimumOrderQuantity;
  List<String>? images;
  List<Map<String, dynamic>>? reviews;

  ProductModel({
    this.id,
    this.title,
    this.description,
    // this.category,
    this.price,
    this.thumbnail,
    // this.discountPercentage,
    this.rating,
    // this.stock,
    this.tags,
    this.returnPolicy,
    // this.minimumOrderQuantity,
    this.images,
    this.reviews,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    // String? category,
    double? price,
    // double? discountPercentage,
    double? rating,
    // int? stock,
    List<String>? tags,
    String? returnPolicy,
    String? thumbnail,
    // int? minimumOrderQuantity,
    List<String>? images,
    List<Map<String, dynamic>>? reviews,
  }) => ProductModel(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    // category: category ?? this.category,
    price: price ?? this.price,
    // discountPercentage: discountPercentage ?? this.discountPercentage,
    rating: rating ?? this.rating,
    // stock: stock ?? this.stock,
    tags: tags ?? this.tags,
    returnPolicy: returnPolicy ?? this.returnPolicy,
    thumbnail: thumbnail ?? this.thumbnail,
    // minimumOrderQuantity: minimumOrderQuantity ?? this.minimumOrderQuantity,
    images: images ?? this.images,
    reviews: reviews ?? this.reviews,
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    // category: json["category"],
    price: json["price"]?.toDouble(),
    // discountPercentage: json["discountPercentage"]?.toDouble(),
    rating: json["rating"]?.toDouble(),
    // stock: json["stock"],
    tags:
        json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
    returnPolicy: json["returnPolicy"],
    thumbnail: json["thumbnail"],
    // minimumOrderQuantity: json["minimumOrderQuantity"],
    images:
        json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
    reviews:
        json["reviews"] == null
            ? []
            : List<Map<String, dynamic>>.from(json['reviews']!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    // "category": category,
    "price": price,
    // "discountPercentage": discountPercentage,
    "rating": rating,
    // "stock": stock,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "returnPolicy": returnPolicy,
    "thumbnail": thumbnail,
    // "minimumOrderQuantity": minimumOrderQuantity,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "reviews":
        reviews == null
            ? []
            : List<Map<String, String>>.from(reviews!.map((x) => x)),
  };
}
