import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/page/auth/login.dart';
import 'package:shop/page/cart/cart.dart';
import 'package:shop/page/category/category.dart';
import 'package:shop/page/home/home.dart';
import 'package:shop/page/order/ordered.dart';
import 'package:shop/page/product/product.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/provider/cart_provider.dart';
import 'package:shop/provider/category_provider.dart';
import 'package:shop/provider/order_provider.dart';
import 'package:shop/provider/product.provider.dart';
import 'package:shop/provider/slider_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SliderProvider()),
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routerName,
      routes: {
        HomePage.routerName: (context) => const HomePage(),
        CategoryPage.routerName: (context) => const CategoryPage(),
        ProductPage.routerName: (context) => const ProductPage(),
        LoginPage.routerName: (context) => LoginPage(),
        CartPage.routerName: (context) => const CartPage(),
        OrderedPage.routerName: (context) => const OrderedPage(),
      },
    ),
  ));
}
