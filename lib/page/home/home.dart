import 'package:flutter/material.dart';
import 'package:shop/page/home/widget/homeSlider.dart';

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
      body: const Column(children: [HomeSlider()]),
    );
  }
}