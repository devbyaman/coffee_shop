import 'package:coffee_shop/models/coffee_item.dart';
import 'package:coffee_shop/screens/item_detail_screen.dart';
import 'package:coffee_shop/screens/checkout_screen.dart';
import 'package:coffee_shop/screens/home_screen.dart';
import 'package:coffee_shop/screens/get_started_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const welcome = '/welcome';
  static const home = '/home';
  static const detail = '/detail';
  static const order = '/order';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(
          builder: (_) => const Welcome(),
        );
      
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Home(),
        );
        
      case Routes.detail:
        return MaterialPageRoute(
          builder: (_) => Detail(
            coffeeItem: settings.arguments as CoffeeItem?,
          ),
        );
        
      case Routes.order:
        return MaterialPageRoute(
          builder: (_) => Order(
            coffeeItem: settings.arguments as CoffeeItem?,
          ),
        );
        
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          ),
        );
    }
  }
}