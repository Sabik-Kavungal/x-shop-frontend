import 'package:flutter/material.dart';
import 'package:learn/views/user/orders/orderHistoryScreen.dart';

class CompactProfilePage extends StatelessWidget {
  static const String routeName = '/profile-screen';
  // Sample data (replace with actual data or state management as needed)
  final String name = 'John Doe';
  final String email = 'johndoe@example.com';
  final String phone = '+1 234 567 890';
  final String address = '123 Main Street, Cityville, Country';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                      backgroundImage:
                          AssetImage('assets/images/profile.png'), // Replace with your image
                      backgroundColor: Colors.grey[300],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: Color(0xFF6200EE),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              // Editable Info Section
              Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 12),
                      // Name TextField (Read-Only)
                      TextField(
                        readOnly: true, // Make the field non-editable
                        controller: TextEditingController(text: name),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person_outline, color: Color(0xFF6200EE)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      // Email TextField (Editable)
                      TextField(
                        controller: TextEditingController(text: email),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined, color: Color(0xFF6200EE)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle email changes
                        },
                      ),
                      SizedBox(height: 12),
                      // Phone Number TextField (Editable)
                      TextField(
                        controller: TextEditingController(text: phone),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone_outlined, color: Color(0xFF6200EE)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle phone number changes
                        },
                      ),
                      SizedBox(height: 12),
                      // Address TextField (Editable)
                      TextField(
                        controller: TextEditingController(text: address),
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelText: 'Address',
                          prefixIcon: Icon(Icons.location_on_outlined, color: Color(0xFF6200EE)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          // Handle address changes
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // Action Buttons Section
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle update profile action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6200EE),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
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
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Change Password',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              // Divider Section for Extra Information (e.g., Account Settings)
              SizedBox(height: 24),
              Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.settings, color: Color(0xFF6200EE)),
                title: Text('Account Settings'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Account Settings screen
                },
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.help_outline, color: Color(0xFF6200EE)),
                title: Text('Help & Support'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Navigate to Help screen
                },
              ),
               SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.shop_sharp, color: Color(0xFF6200EE)),
                title: Text('Orders'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context)=> AllOrdersScreen()));
                },
              ),
              SizedBox(height: 12),
              ListTile(
                leading: Icon(Icons.logout, color: Color(0xFF6200EE)),
                title: Text('Logout'),
                onTap: () {
                  // Handle Logout action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}