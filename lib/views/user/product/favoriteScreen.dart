import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  static const String routeName = '/favorite-screen';
  final List<Map<String, String>> favoriteItems = [
    {
      "image": "https://via.placeholder.com/150", // Replace with actual URLs
      "title": "Modern Sofa",
      "price": "\$599"
    },
    {
      "image": "https://via.placeholder.com/150",
      "title": "Wooden Chair",
      "price": "\$149"
    },
    {
      "image": "https://via.placeholder.com/150",
      "title": "Stylish Desk",
      "price": "\$249"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Your Favorites",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18, // Smaller font size for the title
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: favoriteItems.isEmpty
          ? _buildEmptyFavorites()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0), // Reduced padding for compact design
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Items you love 💖",
                      style: TextStyle(
                        fontSize: 16, // Smaller font size for section heading
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8), // Smaller gap between elements
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: favoriteItems.length,
                      itemBuilder: (context, index) {
                        final item = favoriteItems[index];
                        return _buildFavoriteItem(context, item, index);
                      },
                    ),
                    SizedBox(height: 16), // Add more space at the bottom
                    _buildRelatedItems(), // Added related items section
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildEmptyFavorites() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 60, // Smaller icon size
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 20),
          Text(
            "Your favorites list is empty!",
            style: TextStyle(
              fontSize: 14, // Smaller text size for the empty state
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Add some items to your favorites and they'll appear here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12, // Smaller font size for the additional message
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Map<String, String> item, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
        ),
        padding: const EdgeInsets.all(8), // Smaller padding
        child: Row(
          children: [
            // Item Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item["image"]!,
                height: 60, // Reduced height for image
                width: 60, // Reduced width for image
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["title"]!,
                    style: TextStyle(
                      fontSize: 14, // Smaller title font size
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4), // Smaller gap between title and price
                  Text(
                    item["price"]!,
                    style: TextStyle(
                      fontSize: 12, // Smaller font size for price
                      color: Color(0xFF6200EE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Add to Cart and Remove Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${item['title']} added to cart!"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6), // Smaller padding
                    backgroundColor: Color(0xFF6200EE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: Icon(Icons.shopping_cart, size: 14),
                  label: Text(
                    "Add",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
                SizedBox(height: 4), // Smaller gap
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${item['title']} removed from favorites."),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                  ),
                  child: Text(
                    "Remove",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // New widget: Related Items
  Widget _buildRelatedItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Related Items",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 10),
        // Example related items list
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: favoriteItems.length,
            itemBuilder: (context, index) {
              final item = favoriteItems[index];
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item["image"]!,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      item["title"]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}