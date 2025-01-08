import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/service.dart';
import 'package:learn/models/carts_model.dart';
import 'package:learn/models/category_model.dart';
import 'package:learn/models/item_model.dart';
import 'package:learn/models/order_model.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:learn/views/user/product/favoriteScreen.dart';
import 'package:learn/main.dart';
import 'package:learn/views/user/authentication/profileScreen.dart';

class CartVM with ChangeNotifier {
  final ServiceRepo _repo = ServiceRepo();
  List<CartModel> cartsList = [];
  List<OrderModel> ordersList = [];
  CartModel cartModel = CartModel();
  OrderModel orderModel = OrderModel();

  LocalDatabaseService db = LocalDatabaseService();

  String? error;
  bool isloading = false;
  int _quantity = 1; // Initial quantity for a single product

  int get quantity => _quantity;
  ItemModel item = ItemModel();

  CartVM() {
    getAllCartsItem();
    getAllOrdersItem();
  }
  Future<void> getAllCartsItem() async {
    isloading = true;
    error = null;
    notifyListeners();

    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');

    try {
      final response =
          await _repo.requist('carts', method: "GET", token: token);

      // Check if response and 'carts' key are valid
      if (response != null && response['carts'] is List) {
        cartsList = (response['carts'] as List)
            .map((item) => CartModel.fromJson(item))
            .toList();
      } else {
        error = 'No carts available or invalid response format.';
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  // make add to cart funtion
  Future<void> addToCart(int id) async {
    isloading = true;
    error = null;
    notifyListeners();
    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      cartModel = cartModel.copyWith(itemId: id, quantity: quantity);
      final response = await _repo.requist('carts/add',
          method: "POST", body: cartModel.toJson(), token: token);
      if (response != null) {
        getAllCartsItem();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  // make add to cart funtion
  Future<void> placeOrder() async {
    isloading = true;
    error = null;
    notifyListeners();
    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      // Prepare order items by using copyWith to ensure immutability
      final items = cartsList.map((cartItem) {
        // Safely convert the productPrice from String? to double?
        double? price = cartItem.itemPrice != null
            ? double.tryParse(
                cartItem.itemPrice!) // Try to parse the String to a double
            : null;

        return OrderItem(
          itemId: cartItem.itemId,
          name: cartItem.itemPrice,
          quantity: cartItem.quantity,
          price: price, // Assign the converted price
        );
      }).toList();

      // Calculate total price (replace with your actual calculation logic)
      double totalPrice =
          items.fold(0.0, (sum, item) => sum + (item.price ?? 0.0));

      // Prepare the order using copyWith
      orderModel = orderModel.copyWith(
        totalAmount: totalPrice, // Use the calculated total price
        address: "fdgfd", // Use the address from the input
        items: items,
      );
      print(
          "ddxfg,ldfgjldfigdffgd. .d . .d .f . . .. .  . .. . . . . . . $orderModel");

      final response = await _repo.requist('orders/place',
          method: "POST", body: orderModel.toJson(), token: token);
      if (response != null) {
        getAllCartsItem();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
Future<void> getAllOrdersItem() async {
  isloading = true;
  error = null;
  notifyListeners();

  final boxOpen = await db.openBox("token");
  final token = db.fromDb(boxOpen, 'key');

  try {
    final response =
        await _repo.requist('orders/place', method: "GET", token: token);

    if (response != null && response['orders'] is List) {
      ordersList = (response['orders'] as List)
          .map((item) => OrderModel.fromJson(item))
          .toList();
    } else {
      error = 'No orders available or invalid response format.';
    }
  } catch (e) {
    error = e.toString();
  } finally {
    isloading = false;
    notifyListeners();
  }
}


  void incrementQuantity(int index) {
    if (index >= 0 && index < cartsList.length) {
      final updatedCart = cartsList[index].copyWith(
        quantity: (cartsList[index].quantity ?? 0) + 1,
      );
      cartsList[index] = updatedCart;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 &&
        index < cartsList.length &&
        (cartsList[index].quantity ?? 0) > 1) {
      final updatedCart = cartsList[index].copyWith(
        quantity: (cartsList[index].quantity ?? 0) - 1,
      );
      cartsList[index] = updatedCart;
      notifyListeners();
    }
  }

  void incrementQuantitysingle() {
    _quantity++;
    notifyListeners(); // Notify listeners about the change
  }

  void decrementQuantitysingle() {
    if (_quantity > 1) {
      _quantity--;
      notifyListeners(); // Notify listeners about the change
    }
  }
}
