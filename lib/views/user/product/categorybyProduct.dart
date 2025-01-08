import 'package:flutter/material.dart';
import 'package:learn/providers/homeVM.dart';
import 'package:learn/views/user/product/product_detalScreen.dart';
import 'package:provider/provider.dart';

class CategoryItemsScreen extends StatefulWidget {
  final String? categoryId;
  final String? categoryName;

  const CategoryItemsScreen({Key? key, this.categoryId, this.categoryName})
      : super(key: key);

  @override
  _CategoryItemsScreenState createState() => _CategoryItemsScreenState();
}

class _CategoryItemsScreenState extends State<CategoryItemsScreen> {
  @override
  void initState() {
    super.initState();

    // Add post-frame callback to call the method after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.categoryId != null) {
        // Call your method to fetch data (e.g., from provider or API)
        Provider.of<HomeProvider>(context, listen: false)
            .getCategoriesById(widget.categoryId!);
        Provider.of<HomeProvider>(context, listen: false).itemsList.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName ?? ''),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          final data = provider.itemsList;

          // Handle loading or error states
          if (provider.isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text('Error: ${provider.error}'));
          }

          if (data == null || data.isEmpty) {
            return const Center(
                child: Text('No items available for this category'));
          }

          return ListView.builder(
            itemCount: (data.length / 2).ceil(), // Divide by 2 to display 2 items per row
            itemBuilder: (context, index) {
              final firstItemIndex = index * 2; // Index of the first item in the row
              final secondItemIndex = firstItemIndex + 1; // Index of the second item in the row

              // Check if the second item index exists
              final hasSecondItem = secondItemIndex < data.length;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space out items in the row
                  children: [
                    // First item
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to ProductDetailsScreen for the first item
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                productId: data[firstItemIndex].id.toString(), // Pass product ID
                              ),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(8),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(10),
                            title: Text(
                              data[firstItemIndex].name.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Price: \$${data[firstItemIndex].price}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                            leading: Icon(
                              Icons.shopping_cart,
                              size: 24,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Second item, if it exists
                    if (hasSecondItem)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to ProductDetailsScreen for the second item
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  productId: data[secondItemIndex].id.toString(), // Pass product ID
                                ),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(8),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              title: Text(
                                data[secondItemIndex].name.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'Price: \$${data[secondItemIndex].price}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                              leading: Icon(
                                Icons.shopping_cart,
                                size: 24,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
