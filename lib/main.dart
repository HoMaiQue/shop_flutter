import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/page/home/home.dart';
import 'package:shop/provider/slider_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => SliderProvider())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routerName,
      routes: {HomePage.routerName: (context) => const HomePage()},
    ),
  ));
}
