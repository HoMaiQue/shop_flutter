import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shop/models/slider_model.dart';

class SliderProvider extends ChangeNotifier {
  Future<List<SliderModel>> getDataSlider() async {
    try {
      const url = 'http://apiforlearning.zendvn.com/api/mobile/sliders';
      final res = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(res.body);
      List<SliderModel> list = List<SliderModel>.from(jsonData
          .map((slider) => SliderModel.fromJson(jsonEncode(slider)))).toList();
      return list;
    } catch (error) {
      return Future.error(error);
    }
  }
}
