import 'package:clot/config/config.dart';
import 'package:clot/features/app/data/models/product_model.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<List<dynamic>> getCategoriesFromApi() async {
  Response response;

  response = await dio.get("$baseUrl/category-list");

  try {
    if (response.statusCode == 200) {
      var data = response.data;
      return data;
    }
    print('No data');
    return ["No Data"];
  } catch (e) {
    // print("Error: $e");
    return ["Error: $e"];
  }
}

Future<List<ProductModel>?> getCategorizedProductsFromApi(
  String category,
) async {
  Response response;

  response = await dio.get("$baseUrl/category/$category");

  if (response.statusCode == 200) {
    try {
      var data = response.data;
      var jsonData = data['products'];

      return jsonData == null? [] : List<ProductModel>.from(
        jsonData.map((x) => ProductModel.fromJson(x))
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
