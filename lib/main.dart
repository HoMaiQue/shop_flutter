import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/page/category/category.dart';
import 'package:shop/page/home/home.dart';
import 'package:shop/page/product/product.dart';
import 'package:shop/provider/category_provider.dart';
import 'package:shop/provider/slider_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SliderProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider())
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routerName,
      routes: {
        HomePage.routerName: (context) => const HomePage(),
        CategoryPage.routerName: (context) => const CategoryPage(),
        ProductPage.routerName: (context) => const ProductPage()
      },
    ),
  ));
}
