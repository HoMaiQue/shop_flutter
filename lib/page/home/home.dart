import 'package:flutter/material.dart';
import 'package:shop/const.dart';
import 'package:shop/page/home/widget/home_category.dart';
import 'package:shop/page/home/widget/home_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routerName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("home page"),
      ),
      body: const Column(children: [
        HomeSlider(),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Danh mục sản phẩm",
                style: fdCategory,
              ),
              Text("Tất cả (4)",
                  style: TextStyle(color: Colors.black26, fontSize: 18))
            ],
          ),
        ),
        SizedBox(height: 20),
        HomeCategory(),
      ]),
    );
  }
}
