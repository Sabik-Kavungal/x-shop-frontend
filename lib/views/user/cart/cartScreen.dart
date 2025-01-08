import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:learn/models/carts_model.dart';
import 'package:learn/providers/cartVM.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Cart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Consumer<CartVM>(
        builder: (context, cartVM, child) {
          if (cartVM.isloading) {
            return Center(child: CircularProgressIndicator());
          }
          if (cartVM.error != null) {
            return Center(
              child: Text(
                'Error: ${cartVM.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          // Ensure cartsList is not null
          if (cartVM.cartsList.isEmpty) {
            return Center(
              child: Text(
                'No items in the cart.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: cartVM.cartsList.length,
                  itemBuilder: (context, index) => CartItem(index: index),
                ),
              ),
              // Cart Summary Section
              CartSummary(),
            ],
          );
        },
      ),
    );
  }
}


class CartItem extends StatelessWidget {
  final int index;

  CartItem({required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartVM>(
      builder: (context, cartVM, child) {
        final cartItem = cartVM.cartsList[index];
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage('assets/images/sofa.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cartItem.itemName ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${cartItem.itemPrice ?? ''}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6200EE),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline,
                              color: Color(0xFF6200EE), size: 20),
                          onPressed: () {
                            cartVM.decrementQuantity(index);
                          },
                        ),
                        Text(
                          '${cartItem.quantity}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline,
                              color: Color(0xFF6200EE), size: 20),
                          onPressed: () {
                            cartVM.incrementQuantity(index);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Delete Icon
              IconButton(
                icon: Icon(Icons.delete_outline,
                    color: Color(0xFF6200EE), size: 24),
                onPressed: () {
                  // Implement delete functionality if needed
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PromoCodeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter promo code',
                border: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Apply'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF6200EE),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShippingDetailsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shipping Address',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '123 Main Street, New York, NY 10001',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class CartSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                '\$1,299',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6200EE),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(
              width: double.infinity,
              child: Consumer<CartVM>(
                builder: (context, cartVM, child) {
                  return ElevatedButton.icon(
                    onPressed: () {
                      cartVM.placeOrder().then((_) {
                        // Show success message after the order is placed successfully
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Order placed successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }).catchError((e) {
                        // Handle any errors in placing the order
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error placing order: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      });
                    },
                    icon: Icon(Icons.check_circle, color: Colors.white),
                    label: Text('Place Order'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6200EE),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  );
                },
              )),
        ],
      ),
    );
  }
}
