import 'package:flutter/material.dart';
import 'package:learn/main.dart';
import 'package:learn/views/user/authentication/authScreen.dart';
import 'package:learn/views/user/cart/cartScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) =>  AuthPage(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => HomeScreen(),
      );
    case CartScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CartScreen(),
      );
   



    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
