import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/service.dart';
import 'package:learn/main.dart';
import 'package:learn/models/user_model.dart';
import 'package:learn/views/user/cart/cartScreen.dart';

class AuthVM extends ChangeNotifier {
  final ServiceRepo _userService = ServiceRepo();
  LocalDatabaseService db = LocalDatabaseService();
  bool _isLogin = true;
  bool get isLogin => _isLogin;



  void toggleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
  UserModel user = UserModel();
  bool _isLoading = false;
  String? _message;
  String? _token;
  String? _type;
  String? _id;

  bool get isLoading => _isLoading;
  String? get message => _message;
  String? get token => _token;
  String? get id => _id;
  String? get type => _type;

  // Register user
  Future<void> registerUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _userService.requist(
        "register",
        method: "POST",
        body: user.toJson(),
      );
      _isLoading = false;

      if (response!.containsKey('token')) {
        // Parse token and user details from response
        _token = response['token'];

        if (response['user'] != null) {
          final userJson = response['user'];
          user = UserModel.fromJson(userJson);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // Handle missing token or invalid response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: Invalid response'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> loginUser(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _userService.requist(
        "user/login",
        method: "POST",
        body: user.toJson(),
      );
      _isLoading = false;

      if (response!.containsKey('token')) {
        // Parse token and user details from response
        _token = response['token'];

        if (response['user'] != null) {
          final userJson = response['user'];
          user = UserModel.fromJson(userJson);
        }

        // Save to local storage
        await db.toDb(await db.openBox('token'), "key", _token);
        //  await db.toDb(await db.openBox('id'), "key", user.id);
        await db.toDb(await db.openBox('type'), "key",
            "user"); // Set user type dynamically if available

        // Navigate based on user type
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_type == 'admin') {
            Navigator.pushReplacementNamed(context,  CartScreen.routeName);
          } else {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            backgroundColor: Colors.green,
          ),
        );

        print("Token saved: $_token");
      } else {
        // Handle missing token or invalid response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed: Invalid response'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      _isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      notifyListeners();
    }
  }
}
