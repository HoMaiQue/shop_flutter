import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/category_model.dart';
import 'package:shop/models/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  Future<List<CategoryModel>> getCategoryData() async {
    try {
      const url = "http://apiforlearning.zendvn.com/api/mobile/categories";
      final res = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(res.body);
      List<CategoryModel> list = List<CategoryModel>.from(jsonData.map(
          (category) => CategoryModel.fromJson(jsonEncode(category)))).toList();
      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModel>> getProductByCategoryId(int id) async {
    try {
      final url =
          "http://apiforlearning.zendvn.com/api/mobile/categories/$id/products";
      final res = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(res.body);

      List<ProductModel> list = List<ProductModel>.from(jsonData.map(
          (product) => ProductModel.fromJson(jsonEncode(product)))).toList();
      return list;
    } catch (e) {
      return Future.error(e);
    }
  }
}
