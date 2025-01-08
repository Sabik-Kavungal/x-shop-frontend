import 'package:flutter/material.dart';
import 'package:learn/models/order_model.dart';
import 'package:learn/providers/cartVM.dart';
import 'package:provider/provider.dart';

class AllOrdersScreen extends StatelessWidget {
  static const String routeName = '/all-orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Orders',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Consumer<CartVM>(
        builder: (context, orderVM, child) {
          if (orderVM.isloading) {
            return Center(child: CircularProgressIndicator());
          }

          if (orderVM.error != null) {
            return Center(
              child: Text(
                'Error: ${orderVM.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (orderVM.ordersList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No orders available.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: orderVM.ordersList.length,
            itemBuilder: (context, index) {
              final order = orderVM.ordersList[index];
              return OrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final OrderModel order;

  const OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        title: Text(
          'Order #${order.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Product: ${order.items!.map((item) => item.name).join(', ')}'),
            Text('Total: \$${order.totalAmount}'),
            Text('Status: ${order.status}'),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          // Navigate to Order Details
          Navigator.pushNamed(
            context,
            '/order-details',
            arguments: order.id,
          );
        },
      ),
    );
  }
}
