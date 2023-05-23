import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/provider/order_provider.dart';
import 'package:shop/provider/product.provider.dart';

class OrderedPage extends StatefulWidget {
  const OrderedPage({super.key});
  static const routerName = "/ordered";

  @override
  State<OrderedPage> createState() => _OrderedPageState();
}

class _OrderedPageState extends State<OrderedPage> {
  final bool _customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Ordered"),
        ),
        body: FutureBuilder(
            future: Provider.of<OrderProvider>(context).getOrderedList(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List data = snapshot.data as List;
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        List dataItem = data[index]["order_items"] as List;
                        return ExpansionTile(
                          title: Text('Mã đơn hàng: ${data[index]["code"]}'),
                          subtitle: Text(DateFormat("kk:mm - dd-MM-yyyy")
                              .format(
                                  DateTime.parse(data[index]["created_at"]))),
                          children: <Widget>[
                            ListView.separated(
                              separatorBuilder: (context, index) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return FutureBuilder(
                                    future: Provider.of<ProductProvider>(
                                            context,
                                            listen: false)
                                        .getProductById(
                                            dataItem[index]["product_id"]),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      ProductModel product =
                                          snapshot.data as ProductModel;
                                      return snapshot.hasData
                                          ? ListTile(
                                              leading: Image(
                                                  image: NetworkImage(
                                                      product.image)),
                                              title: Text(product.name),
                                            )
                                          : SvgPicture.asset(
                                              "assets/images/svg/no_data.svg",
                                              width: 200,
                                              height: 200);
                                    });
                              },
                              itemCount: dataItem.length,
                            )
                          ],
                        );
                      },
                    )
                  : SvgPicture.asset("assets/images/svg/no_data.svg",
                      width: 100, height: 100);
            })));
  }
}
