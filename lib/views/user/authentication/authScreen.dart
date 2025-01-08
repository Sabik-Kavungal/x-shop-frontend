import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
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
                    hintText: "Full Name",
                    icon: Icons.person,
                    isPassword: false,
                  ),
                  SizedBox(height: 15),
                ],
                _buildTextField(
                  hintText: "Email",
                  icon: Icons.email,
                  isPassword: false,
                ),
                SizedBox(height: 15),
                _buildTextField(
                  hintText: "Password",
                  icon: Icons.lock,
                  isPassword: true,
                ),
                SizedBox(height: 25),

                // Login/Register Button
                ElevatedButton(
                  onPressed: () {
                    // Handle login or registration logic
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
                    setState(() {
                      isLogin = !isLogin;
                    });
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
  }) {
    return TextField(
      obscureText: isPassword,
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
