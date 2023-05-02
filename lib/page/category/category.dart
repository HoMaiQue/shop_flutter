import 'package:flutter/material.dart';
import 'package:shop/page/category/widget/category_body.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  static const routerName = "/category";
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    print(args);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(args["name"]),
        ),
        body: const CategoryBody());
  }
}
