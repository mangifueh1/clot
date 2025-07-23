import 'package:clot/config/config.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

Future<List<ProductModel>?> getProducts(String category) async {
  Response response;

  response = await dio.get('$baseUrl/category/$category');

  if (response.statusCode == 200) {
    try {
      var data = response.data;
      var products = data['products'];
      return products == null
          ? []
          : List<ProductModel>.from(
            products.map((x) => ProductModel.fromJson(x)),
          );
    } catch (e) {
      print("Error: $e");
      return null;
    }
  } else {
    print("Null ");
    return null;
  }
}
