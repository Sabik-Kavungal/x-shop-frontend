import 'package:flutter/material.dart';
import 'package:learn/config/service.dart';
import 'package:learn/models/category_model.dart';
import 'package:learn/models/item_model.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:learn/views/user/product/favoriteScreen.dart';
import 'package:learn/main.dart';
import 'package:learn/views/user/authentication/profileScreen.dart';

class HomeProvider with ChangeNotifier {
  int selectIndex = 0;
  final ServiceRepo _repo = ServiceRepo();
  List<ItemModel> itemsList = [];
  List<CategoryModel> categoriesList = [];
  String? error;
  bool isloading = false;

  ItemModel item = ItemModel();

  HomeProvider() {
    getAllItems();
    getAllcategories();
  }

  Future<void> getAllItems() async {
    isloading = true;
    error = null;
    notifyListeners();
    try {
      final response = await _repo.requist('items', method: "GET");
      if (response != null) {
        itemsList = (response['data'] as List)
            .map((item) => ItemModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getItemById(String id) async {
    isloading = true;
    error = null;
    notifyListeners();
    try {
      final response = await _repo.requist('items/$id', method: "GET");

      if (response != null && response['data'] != null) {
        // Assuming 'data' contains a single item object, not a list
        item = ItemModel.fromJson(response['data']); // Adjusted for single item
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getAllcategories() async {
    isloading = true;
    error = null;
    notifyListeners();
    try {
      final response = await _repo.requist('category', method: "GET");
      if (response != null) {
        categoriesList = (response['data'] as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getCategoriesById(String id) async {
    isloading = true;
    error = null;
    notifyListeners();
    try {
      final response = await _repo.requist('category/items/$id', method: "GET");
      if (response != null) {
        itemsList = (response['items'] as List)
            .map((item) => ItemModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void setSelectINdex(int index) {
    selectIndex = index;
    notifyListeners();
  }

  final List<Widget> _pages = [
    HomeScreen(),
    FavoritesPage(),
    CompactProfilePage(),
    CartScreen()
  ];

  Widget get currentPage => _pages[selectIndex];



}
