import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import 'package:shop/provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routerName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Giỏ hàng"),
      ),
      body: Stack(
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
                              InkWell(onTap: (){
                                Provider.of<CartProvider>(context).decrease(cart[index].id);
                              },child: const Icon(Icons.remove)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(cart[index].quantity.toString(),
                                    style: const TextStyle(color: Colors.blue)),
                              ),
                              InkWell(onTap:(){
                                Provider.of<CartProvider>(context).increase(cart[index].id);
                              },child: const Icon(Icons.add))
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
                  onPressed: () {},
                  child: const Text("Mua hàng"),
                ),
              ))
        ],
      ),
    );
  }
}
