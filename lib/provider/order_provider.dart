import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  Future<bool> buy(Map<int, dynamic> cart) async {
    const url = 'http://apiforlearning.zendvn.com/api/mobile/orders/save';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode(prefs.getString("userData") ?? "");
    final token = userData["access_token"];
    var data = [];

    cart.forEach((key, value) {
      data.add({"product_id": key, "quantity": value.quantity});
    });
    try {
      final res = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode({"data": data}));

      if (res.statusCode == 201) {
        return false;
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
