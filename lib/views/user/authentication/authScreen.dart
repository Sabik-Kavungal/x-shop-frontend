import 'package:flutter/material.dart';
import 'package:learn/providers/authVM.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<AuthVM>(
              builder: (context, userVm, child) {
                final isLogin = userVm.isLogin;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo or Header
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Color(0xFF6200EE),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      isLogin ? "Welcome Back!" : "Create Account",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      isLogin ? "Login to continue" : "Register to get started",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Form Fields
                    if (!isLogin) ...[
                      _buildTextField(
                          initialValue: userVm.user.name,
                          hintText: "Full Name",
                          icon: Icons.person,
                          isPassword: false,
                          onChanged: (x) {
                            userVm.user = userVm.user.copyWith(name: x);
                          }),
                      SizedBox(height: 15),
                    ],
                    _buildTextField(
                        initialValue: userVm.user.email,
                        hintText: "Email",
                        icon: Icons.email,
                        isPassword: false,
                        onChanged: (x) {
                          userVm.user = userVm.user.copyWith(email: x);
                        }),
                    SizedBox(height: 15),
                    _buildTextField(
                        initialValue: userVm.user.password,
                        hintText: "Password",
                        icon: Icons.lock,
                        isPassword: true,
                        onChanged: (x) {
                          userVm.user = userVm.user.copyWith(password: x);
                        }),
                    SizedBox(height: 25),

                    // Login/Register Button
                    ElevatedButton(
                      onPressed: () {
                        userVm.isLogin
                            ? userVm.loginUser(context)
                            : userVm.registerUser(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6200EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 30,
                        ),
                      ),
                      child: Text(
                        isLogin ? "Login" : "Register",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Toggle Between Login and Registration
                    TextButton(
                      onPressed: () {
                        userVm.toggleLogin();
                      },
                      child: Text(
                        isLogin
                            ? "Don't have an account? Register"
                            : "Already have an account? Login",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Custom Text Field
  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required bool isPassword,
    String? initialValue,
    ValueChanged<String>? onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Color(0xFF6200EE)),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
