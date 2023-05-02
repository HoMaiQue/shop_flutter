import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/page/category/category.dart';
import 'package:shop/provider/category_provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({super.key});

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future categoryFuture;

  @override
  void didChangeDependencies() {
    categoryFuture = Provider.of<CategoryProvider>(context).getCategoryData();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoryFuture,
      initialData: const [],
      builder: (context, asyncSnapshot) {
        final categoryData =
            asyncSnapshot.hasData ? asyncSnapshot.data as List : [];
        return SizedBox(
          height: 70,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, CategoryPage.routerName,
                        arguments: {"id": categoryData[index].id, "name": categoryData[index].name});
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                            boxShadow: const [],
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(categoryData[index].image),
                                fit: BoxFit.contain)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(categoryData[index].name)
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 20);
              },
              itemCount: categoryData.length),
        );
      },
    );
  }
}
