import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/service.dart';
import 'package:learn/main.dart';
import 'package:learn/models/user_model.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:image_picker/image_picker.dart'; // Import the image picker package
import 'dart:io';

class AuthVM extends ChangeNotifier {
  final ServiceRepo _userService = ServiceRepo();
  LocalDatabaseService db = LocalDatabaseService();
  bool _isLogin = true;
  bool get isLogin => _isLogin;

  bool _isEditable = false; // Flag to control editable state
  bool get isEditable => _isEditable;

  AuthVM() {
    getProfile();
  }

  void toggleEditMode() {
    _isEditable = !_isEditable; // Toggle the edit mode
    notifyListeners();
  }

  void toggleLogin() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  File? _pickedImage; // To store the selected image file
  File? get pickedImage => _pickedImage;
  // Image picker method
  Future<void> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    // Choose either camera or gallery
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery, // Use ImageSource.camera for camera
      imageQuality: 50, // Adjust image quality if needed
    );

    if (image != null) {
      _pickedImage = File(image.path); // Store the picked image file
      notifyListeners();
    }
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
            Navigator.pushReplacementNamed(context, CartScreen.routeName);
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

  logoutUser() async {
    final a = await db.openBox("token");
    db.deleteDb(a, 'key');
    print("User logged out successfully");
    notifyListeners();
  }

  Future<void> getProfile() async {
    _isLoading = true;

    notifyListeners();
    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      final response = await _userService.requist("user/profile",
          method: "GET", token: token);

      if (response != null && response.containsKey('user')) {
        user = UserModel.fromJson(response['user']);

        print(user);
      }
    } catch (ee) {
      ee.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final boxOpen = await db.openBox("token");
    final token = db.fromDb(boxOpen, 'key');
    try {
      // If _pickedImage is not null, convert it to the image path string
      String? imagePath = _pickedImage?.path; // Convert to String (file path)

      // Use the image path (string) in user.copyWith instead of the File
      user = user.copyWith(
        name: user.name,
        address: user.address,
        email: user.email,
        phone: user.phone,
        image: imagePath, // Now image is a String (path)
      );

      final response = await _userService.requist(
        "user/profile",
        method: "PUT",
        body: user.toJson(),
        token: token,
      );

      if (response != null && response.containsKey('user')) {
        user = UserModel.fromJson(response['user']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
