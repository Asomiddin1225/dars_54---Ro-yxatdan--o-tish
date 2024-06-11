import 'dart:convert';

import 'package:dars_54/models/plan.dart';
import 'package:http/http.dart' as http;



class ProductsHttpServices {
  Future<List<Plan>> getProducts() async {
    Uri url = Uri.parse(
        "https://dars46-43428-default-rtdb.firebaseio.com/praducts.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Plan> loadedProducts = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        loadedProducts.add(Plan.fromJson(value));
      });
    }

    return loadedProducts;
  }

  Future<Plan?> addProduct(
    String title,
    String reja,
    String sana,
  ) async {
    Uri url = Uri.parse(
        "https://dars46-43428-default-rtdb.firebaseio.com/praducts.json");

    Map<String, dynamic> productData = {
      "title": title,
      "reja": reja,
      "sana": sana,
    };
    final response = await http.post(
      url,
      body: jsonEncode(productData),
    );
    final data = jsonDecode(response.body);
    if (data != null) {
      productData['id'] = data['name'];
      Plan newProduct = Plan.fromJson(productData);
      return newProduct;
    }

    return null;
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    String newReja,
    String newSana,
  ) async {
    Uri url = Uri.parse(
        "https://dars46-43428-default-rtdb.firebaseio.com/praducts/$id.json");

    Map<String, dynamic> productData = {
      "title": newTitle,
      "reja": newReja,
      "sana": newSana,
    };
    await http.patch(
      url,
      body: jsonEncode(productData),
    );
  }

  Future<void> deleteProduct(String id) async {
    Uri url = Uri.parse(
        "https://dars46-43428-default-rtdb.firebaseio.com/praducts/$id.json");

    await http.delete(url);
  }
}
