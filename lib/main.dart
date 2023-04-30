import 'package:flutter/material.dart';
import 'package:shop/page/home/widget/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: HomePage.routerName,
    routes: {HomePage.routerName: (context) => const HomePage()},
  ));
}
