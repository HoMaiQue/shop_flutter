import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shop/const.dart';
import 'package:shop/page/auth/login.dart';
import 'package:shop/page/cart/cart.dart';
import 'package:shop/page/home/widget/home_category.dart';
import 'package:shop/page/home/widget/home_slider.dart';
import 'package:shop/page/home/widget/special_product.dart';
import 'package:shop/page/order/ordered.dart';
import 'package:shop/provider/auth_provider.dart';
import 'package:shop/provider/cart_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routerName = "/";
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return auth.isAuth
            ? const Home()
            : FutureBuilder(
                future: auth.autoLogin(),
                initialData: false,
                builder: (context, asyncData) {
                  if (asyncData.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return asyncData.data as bool ? const Home() : LoginPage();
                });
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("home page"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: Consumer<CartProvider>(builder: (context, value, child) {
              return Badge(
                label: Text(value.cart.length.toString()),
                child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, CartPage.routerName);
                    },
                    child: const Icon(Icons.shopping_cart)),
              );
            }),
          )
        ],
      ),
      body: const Column(children: [
        HomeSlider(),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Danh mục sản phẩm",
                style: fdCategory,
              ),
              Text("Tất cả (4)",
                  style: TextStyle(color: Colors.black26, fontSize: 18))
            ],
          ),
        ),
        SizedBox(height: 20),
        HomeCategory(),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sản phẩm đặt biệt",
                style: fdCategory,
              ),
              Text("Tất cả (4)",
                  style: TextStyle(color: Colors.black26, fontSize: 18))
            ],
          ),
        ),
        SizedBox(height: 20),
        SpecialProduct()
      ]),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              SizedBox(
                  child: SvgPicture.asset("assets/images/svg/logo.svg",
                      width: 80, height: 80)),
              const SizedBox(height: 10),
              SizedBox(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home),
                      title: const Text("Home page"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.library_books),
                      title: const Text("Ordered"),
                      onTap: () {
                        Navigator.popAndPushNamed(context, OrderedPage.routerName);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Log out"),
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false)
                            .logout();
                      },
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
