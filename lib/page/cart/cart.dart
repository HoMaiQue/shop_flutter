import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shop/helper/alert.dart';
import 'package:shop/provider/cart_provider.dart';
import 'package:shop/provider/order_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  static const routerName = "/cart";

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void handleAddCart() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alertLoading;
        });
    Future.delayed(const Duration(seconds: 3), (() {
      Provider.of<OrderProvider>(context, listen: false)
          .buy(Provider.of<CartProvider>(context, listen: false).cart)
          .then((value) => {
                if (value)
                  {
                    Navigator.pop(context),
                    showDialog(
                        context: context,
                        builder: (context) {
                          return alertSuccess;
                        }),
                    Provider.of<CartProvider>(context, listen: false)
                        .removeCart(),
                  }
              })
          .catchError((onError) => {print(onError)});
    }));
  }

  @override
  Widget build(BuildContext context) {
    final cartList = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Giỏ hàng"),
      ),
      body: cartList.isNotEmpty
          ? Stack(
              children: [
                Consumer<CartProvider>(
                  builder: ((context, value, child) {
                    List<CartItem> cart = value.cart.values.toList();
                    return Positioned.fill(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image(
                                  image: NetworkImage(cart[index].imageName),
                                  fit: BoxFit.fill),
                              title: Text(
                                cart[index].name,
                                maxLines: 2,
                              ),
                              subtitle: Text(intl.NumberFormat.simpleCurrency(
                                      locale: "vi", decimalDigits: 0)
                                  .format(cart[index].price)),
                              trailing: SizedBox(
                                width: MediaQuery.of(context).size.width / 4,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .decrease(value.cart.keys
                                                  .toList()[index]);
                                        },
                                        child: const Icon(Icons.remove)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                          cart[index].quantity.toString(),
                                          style: const TextStyle(
                                              color: Colors.blue)),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Provider.of<CartProvider>(context,
                                                  listen: false)
                                              .increase(value.cart.keys
                                                  .toList()[index]);
                                        },
                                        child: const Icon(Icons.add))
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: value.cart.length),
                    );
                  }),
                ),
                Positioned(
                    bottom: 10,
                    right: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: handleAddCart,
                        child: const Text("Mua hàng"),
                      ),
                    ))
              ],
            )
          : Container(
              child: Center(
              child: SvgPicture.asset("assets/images/svg/no_data.svg",
                  width: 200, height: 200),
            )),
    );
  }
}
