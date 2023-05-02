import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});
  static const routerName = "/product";
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map;
    final product = data["data"];
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 320.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                product.name,
              ),
              background: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Image(
                    fit: BoxFit.contain,
                    image: NetworkImage(
                      product.image,
                    )),
              ),
            )),
        SliverToBoxAdapter(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                product.description,
                maxLines: 10,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Icon(Icons.remove)),
                const SizedBox(
                  width: 30,
                ),
                const Text('1'),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(onPressed: () {}, child: const Icon(Icons.add))
              ],
            ),
          ],
        ))
      ]),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {}, child: const Text("Add Product")),
          ),
        )
      ],
    );
  }
}
