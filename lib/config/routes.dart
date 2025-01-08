import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // case LoginScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const LoginScreen(),
    //   );
    // case ItemsPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ItemsPage(),
    //   );
    // case CategoryPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => CategoryPage(),
    //   );
    // case HomePage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => HomePage(),
    //   );
    // case OrdersPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => OrdersPage(),
    //   );
    // case ReportsPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ReportsPage(),
    //   );

    // case UserHomeScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => UserHomeScreen(),
    //   );

    //    case HomeScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => HomeScreen(),
    //   );
    //    case CartScreen.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => CartScreen(),
    //   );



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
