import 'package:flutter/material.dart';
import 'package:learn/providers/cartVM.dart';
import 'package:learn/providers/homeVM.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details-screen';

  // Product ID passed to the screen
  final String productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    // Add post-frame callback to call the method after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.productId.isNotEmpty) {
        // Call your method to fetch data (e.g., from provider or API)
        Provider.of<HomeProvider>(context, listen: false)
            .getItemById(widget.productId); // Use the correct variable name
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer2<HomeProvider, CartVM>(
        builder: (context, provider, cartVM, child) {
          // Fetch product details using product ID
          final product = provider.item; // Ensure item is available

          // If product is not found or still loading, show loading indicator
          if (product == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.grey[200], // Use a background color if no image
                ),
                child: Center(
                  child: Icon(
                    Icons.image, // Placeholder icon
                    size: 80, // Icon size
                    color: Colors.grey, // Icon color
                  ),
                ),
              ),

              SizedBox(height: 16),
              // Product Details
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? 'No Name', // Display product name
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$${product.price}', // Display product price
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.star,
                                    color: Colors.orange, size: 20),
                                SizedBox(width: 4),
                                Text('3'),
                                SizedBox(width: 4),
                                Text(
                                  '3 Reviews',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Spacer(),
                            // Quantity Selector
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    cartVM.decrementQuantitysingle();
                                  },
                                ),
                                Text(cartVM.quantity.toString()),
                                IconButton(
                                  icon: Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartVM.incrementQuantitysingle();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Tab Bar
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.orange,
                                tabs: [
                                  Tab(text: 'Description'),
                                  Tab(text: 'Materials'),
                                  Tab(text: 'Reviews'),
                                ],
                              ),
                              SizedBox(
                                height: 120,
                                child: TabBarView(
                                  children: [
                                    Text(
                                      product.description ??
                                          'No description available.',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "Materials info here",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Text(
                                      "Reviews: 3",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        // Similar Products Section (You can implement this later)
                        Text(
                          'Similar products',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Call the provider method to add the product to the cart
            Provider.of<CartVM>(context, listen: false)
                .addToCart(int.parse(widget.productId))
                .then((_) {
              // Show a success message after the product is added to the cart
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added to cart successfully!'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            }).catchError((error) {
              // Handle any errors that occur
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Failed to add to cart: $error'),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              );
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Add to bag',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
