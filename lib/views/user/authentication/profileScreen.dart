import 'package:flutter/material.dart';
import 'package:learn/providers/authVM.dart';
import 'package:learn/views/user/orders/orderHistoryScreen.dart';
import 'package:provider/provider.dart';

// Import your AuthVM class

class CompactProfilePage extends StatelessWidget {
  static const String routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<AuthVM>(
        builder: (context, authVM, _) {
          final user = authVM.user; // Fetch user data from the AuthVM
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Image Section
                  Center(
                      child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: authVM.user.image != null &&
                                authVM.user.image!.isNotEmpty
                            ? NetworkImage(
                                "https://x-shop-backend.onrender.com/uploads/${authVM.user.image}")
                            : null,
                        backgroundColor: Colors.grey[300],
                        child: authVM.user.image == null ||
                                authVM.user.image!.isEmpty
                            ? Icon(Icons.person,
                                size: 50, color: Colors.grey[600])
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            authVM.pickImage(
                                context); // Call image picker when camera icon is tapped
                          },
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6200EE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),

                  const SizedBox(height: 24),
                  // Editable Info Section
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Name TextField (Read-Only)
                        TextField(
                          readOnly: !authVM.isEditable,
                          controller: TextEditingController(text: user.name),
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: const Icon(Icons.person_outline,
                                color: Color(0xFF6200EE)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            authVM.user = authVM.user.copyWith(name: value);
                          },
                        ),
                        const SizedBox(height: 12),
                        // Email TextField (Editable)
                        TextField(
                          readOnly: !authVM.isEditable,
                          controller: TextEditingController(text: user.email),
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined,
                                color: Color(0xFF6200EE)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            authVM.user = authVM.user.copyWith(email: value);
                          },
                        ),
                        const SizedBox(height: 12),
                        // Phone Number TextField (Editable)
                        TextField(
                          readOnly: !authVM.isEditable,
                          controller: TextEditingController(text: user.phone),
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: const Icon(Icons.phone_outlined,
                                color: Color(0xFF6200EE)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            authVM.user = authVM.user.copyWith(phone: value);
                          },
                        ),
                        const SizedBox(height: 12),
                        // Address TextField (Editable)
                        TextField(
                          readOnly: !authVM.isEditable,
                          controller: TextEditingController(text: user.address),
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Address',
                            prefixIcon: const Icon(Icons.location_on_outlined,
                                color: Color(0xFF6200EE)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            authVM.user = authVM.user.copyWith(address: value);
                          },
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons Section
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (authVM.isEditable) {
                              authVM.updateProfile(context);
                            }
                            authVM.toggleEditMode(); // Toggle edit mode
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: authVM.isEditable
                                ? Colors.red
                                : const Color(0xFF6200EE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Update Profile',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle change password action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text(
                            'Change Password',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Additional Options
                  const SizedBox(height: 24),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading:
                        const Icon(Icons.settings, color: Color(0xFF6200EE)),
                    title: const Text('Account Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to Account Settings screen
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.help_outline,
                        color: Color(0xFF6200EE)),
                    title: const Text('Help & Support'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigate to Help screen
                    },
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Color(0xFF6200EE)),
                    title: const Text('Logout'),
                    onTap: () {
                      authVM.logoutUser();
                      Navigator.pushReplacementNamed(context, '/auth-screen');
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
