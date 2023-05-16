import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

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
          Positioned.fill(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Image(
                        image:
                            NetworkImage("http://placeimg.com/640/480/animals"),
                        fit: BoxFit.fill),
                    title: const Text(
                      "Ratione non est.",
                      maxLines: 2,
                    ),
                    subtitle: Text(intl.NumberFormat.simpleCurrency(
                            locale: "vi", decimalDigits: 0)
                        .format(20000323)),
                    trailing: SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: const Row(
                        children: [
                          Icon(Icons.remove),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text("123",
                                style: TextStyle(color: Colors.blue)),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 10),
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
