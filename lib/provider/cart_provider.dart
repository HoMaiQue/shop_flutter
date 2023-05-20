// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CartItem {
  final int id;
  final String imageName;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.id,
    required this.imageName,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> cart = {};

  void addCart(int id, String image, String name, int price,
      [int quantity = 1]) {
    if (cart.containsKey(id)) {
      cart.update(
          id,
          (value) => CartItem(
              id: value.id,
              imageName: value.imageName,
              name: value.name,
              price: value.price,
              quantity: value.quantity + quantity));
    } else {
      cart.putIfAbsent(
          id,
          () => CartItem(
              id: id,
              imageName: image,
              name: name,
              price: price,
              quantity: quantity));
    }
    notifyListeners();
  }

  void increase(int productId, [int quantity = 1]) {
    cart.update(
        productId,
        (value) => CartItem(
            id: value.id,
            imageName: value.imageName,
            name: value.name,
            price: value.price,
            quantity: value.quantity + quantity));

    notifyListeners();
  }

  void decrease(int productId, [int quantity = 1]) {
    if (cart[productId]?.quantity == quantity) {
      cart.removeWhere((key, value) => key == productId);
    }
    cart.update(
        productId,
        (value) => CartItem(
            id: value.id,
            imageName: value.imageName,
            name: value.name,
            price: value.price,
            quantity: value.quantity - quantity));

    notifyListeners();
  }
}
