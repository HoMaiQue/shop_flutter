import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/provider/cart_provider.dart';
import 'package:shop/provider/product.provider.dart';

class SpecialProduct extends StatelessWidget {
  const SpecialProduct({super.key});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: FutureBuilder(
            initialData: const [],
            future: Provider.of<ProductProvider>(context).getProductSpecial(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<ProductModel> productList =
                  snapshot.hasData ? snapshot.data as List<ProductModel> : [];
              return snapshot.hasData
                  ? ListView.separated(
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: Image(
                            image: NetworkImage(productList[index].image),
                            fit: BoxFit.fill,
                          ),
                          title: Text(productList[index].name),
                          subtitle: Text(intl.NumberFormat.simpleCurrency(
                                  locale: "vi", decimalDigits: 0)
                              .format(productList[index].price)),
                          trailing: InkWell(
                              onTap: () {
                                Provider.of<CartProvider>(context, listen: false).addCart(productList[index].id, productList[index].image, productList[index].name, productList[index].price);
                              },
                              child: const Icon(Icons.shopping_cart_checkout)),
                        );
                      }),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 1,
                        );
                      },
                      itemCount: productList.length)
                  : const Center(
                      child: Text(' No data'),
                    );
            })));
  }
}
