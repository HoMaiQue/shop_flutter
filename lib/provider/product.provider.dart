import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productSpecial = [];

  Future<List<ProductModel>> getProductSpecial() async {
    try {
      const url =
          "http://apiforlearning.zendvn.com/api/mobile/products?offset=0&sortBy=id&order=asc&special=true";
      final res = await http.get(Uri.parse((url)));
      final jsonData = jsonDecode(res.body);
      List<ProductModel> data = List<ProductModel>.from(jsonData.map(
          (product) => ProductModel.fromJson(jsonEncode(product)))).toList();
      productSpecial = data;
      return data;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final url = "http://apiforlearning.zendvn.com/api/mobile/products/$id";
      final res = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(res.body);
      ProductModel product = ProductModel.fromJson(jsonEncode(jsonData));
      return product;
    } catch (e) {
      return Future.error(e);
    }
  }
}
