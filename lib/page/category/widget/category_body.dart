import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/page/product/product.dart';
import 'package:shop/provider/category_provider.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late Future ProductFuture;
  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    ProductFuture = Provider.of<CategoryProvider>(context)
        .getProductByCategoryId(args["id"]);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: FutureBuilder(
          initialData: const [],
          future: ProductFuture,
          builder: (context, asyncData) {
            List productList = asyncData.hasData ? asyncData.data as List : [];
            if (productList.isEmpty) {
              return Container(child: const Text("No Product"));
            }
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 4),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ProductPage.routerName,
                          arguments: {"data": productList[index]});
                    },
                    child: GridTile(
                      footer: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(20)),
                        child: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(productList[index].name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productList[index].description),
                              const SizedBox(height: 4),
                              Text(productList[index].price.toString(),
                                  style: const TextStyle(
                                      color: Colors.yellow, fontSize: 16))
                            ],
                          ),
                          trailing: const Icon(Icons.shopping_cart),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                                image: NetworkImage(productList[index].image),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
