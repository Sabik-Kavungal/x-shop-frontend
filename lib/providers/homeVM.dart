import 'package:flutter/material.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:learn/views/user/product/favoriteScreen.dart';
import 'package:learn/main.dart';
import 'package:learn/views/user/authentication/profileScreen.dart';

class HomeProvider with ChangeNotifier {
  int selectIndex = 0;

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
