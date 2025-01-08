import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      "orderId": "123456",
      "date": "Jan 1, 2025",
      "status": "Pending",
      "total": "\$199.99",
    },
    {
      "orderId": "123457",
      "date": "Dec 20, 2024",
      "status": "Completed",
      "total": "\$299.49",
    },
    {
      "orderId": "123458",
      "date": "Nov 15, 2024",
      "status": "Cancelled",
      "total": "\$0.00",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background for a clean look
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Order History",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20, // Smaller title font size
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Padding to make everything feel less cramped
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4, // Subtle elevation for a minimalistic look
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners for a soft look
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0), // Reduced padding for a compact layout
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID and Date with smaller font
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order #${order['orderId']}",
                          style: TextStyle(
                            fontSize: 14, // Smaller font size
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          order['date'],
                          style: TextStyle(
                            fontSize: 12, // Smaller font size for the date
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    // Order Status with smaller badge size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: _getStatusColor(order['status']),
                            borderRadius: BorderRadius.circular(20), // Smaller rounded badge
                          ),
                          child: Text(
                            order['status'],
                            style: TextStyle(
                              fontSize: 12, // Smaller font size for status
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          order['total'],
                          style: TextStyle(
                            fontSize: 14, // Smaller font size for the total
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // View Details Button with compact design
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle View Details Action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF6200EE),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Smaller rounded button
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 20,
                          ),
                          elevation: 2, // Subtle elevation for the button
                        ),
                        child: Text(
                          "View Details",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Related Orders Section
                    Row(
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.grey[600],
                          size: 16, // Smaller icon size
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Related Orders",
                          style: TextStyle(
                            fontSize: 14, // Smaller font size
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    // Example related order widget with a clean, compact layout
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order #123459",
                            style: TextStyle(
                              fontSize: 12, // Smaller font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Date: Dec 5, 2024",
                            style: TextStyle(
                              fontSize: 10, // Smaller font size
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Status: Completed",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Total: \$189.99",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Function to return status color
  Color _getStatusColor(String status) {
    switch (status) {
      case "Pending":
        return Colors.orange;
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
