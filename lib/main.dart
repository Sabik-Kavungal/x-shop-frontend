import 'package:flutter/material.dart';
import 'package:learn/views/user/authentication/authScreen.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:learn/views/user/product/favoriteScreen.dart';
import 'package:learn/views/user/orders/orderHistoryScreen.dart';
import 'package:learn/views/user/product/product_detalScreen.dart';
import 'package:learn/views/user/authentication/profileScreen.dart';
import 'package:learn/providers/homeVM.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HomeProvider())],
      child: HomePageApp()));
}

class HomePageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Color(0xFFFFFFFF), // Default barckground color
        primarySwatch: Colors.red, // Default primary color for your app
        appBarTheme: AppBarTheme(
            //  backgroundColor: Color(0xFF6200EE), // AppBar background color
            ),
      ),
      home: Scaffold(
        body: Consumer<HomeProvider>(builder: (context, p, childs) {
          return p.currentPage;
        }),
         bottomNavigationBar:
          Consumer<HomeProvider>(builder: (context, pro, child) {
        return BottomNavigationBar(
            currentIndex: pro.selectIndex,
            onTap: (v) {
              pro.setSelectINdex(v);
            },
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF6200EE),
            unselectedItemColor: Colors.grey,
            items: List.generate(
              4,
              (index) {
                return BottomNavigationBarItem(
                  icon: Icon(
                      [
                        Icons.home,
                        Icons.favorite,
                        Icons.person,
                        Icons.shopping_bag
                      ][index],
                      color: Colors.grey[400],
                      size: 24),
                  label: ['Home', 'Favorite', 'Profile', 'cart'][index],
                );
              },
            ));
      }),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Roboto',
          ),
        ),
        // actions: [
        //   _buildAppBarIcon(
        //       Icons.notifications, context, () => ProductDetailsScreen()),
        //   _buildAppBarIcon(Icons.card_travel, context, () => CartScreen()),
        //   _buildAppBarIcon(
        //       Icons.person_outline, context, () => CompactProfilePage()),
        //   _buildAppBarIcon(Icons.history, context, () => OrderHistoryPage()),
        //   _buildAppBarIcon(
        //       Icons.favorite_border, context, () => FavoritesPage()),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore What\nYour Home Needs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for items...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 13),
              _buildSectionHeader('Categories', context),
              SizedBox(height: 11),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryCard('Chair', Icons.chair_alt),
                  _buildCategoryCard('Sofa', Icons.weekend),
                  _buildCategoryCard('Desk', Icons.table_bar),
                  _buildCategoryCard('Table', Icons.chair),
                ],
              ),
              SizedBox(height: 20),
              _buildPromoBanner(),
              SizedBox(height: 20),
              _buildSectionHeader('Deals of the Day', context),
              SizedBox(height: 12),
              _buildDealsSection(),
              SizedBox(height: 20),
              _buildSectionHeader('Popular', context),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPopularItemCard(
                      'https://th.bing.com/th/id/OIP.35EPQCdixcZkdCubgB0fbgHaEP?w=626&h=358&rs=1&pid=ImgDetMain'),
                  _buildPopularItemCard(
                      'https://th.bing.com/th/id/OIP.35EPQCdixcZkdCubgB0fbgHaEP?w=626&h=358&rs=1&pid=ImgDetMain'),
                ],
              ),
            ],
          ),
        ),
      ),
     
    );
  }

  Widget _buildAppBarIcon(
      IconData icon, BuildContext context, Widget Function() navigateTo) {
    return IconButton(
      icon: Icon(icon, color: Colors.orange),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => navigateTo())),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See all',
            style: TextStyle(color: Color(0xFF6200EE)),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF6200EE), size: 28),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'High-quality sofa started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '70% off',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all items',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://th.bing.com/th/id/OIP.aOwxAEeMY5-zzpH_uEmqnAHaFj?w=1000&h=750&rs=1&pid=ImgDetMain',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDealsSection() {
    return Container(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildDealCard(
              'Modern Lamp', 'https://via.placeholder.com/150', '\$49.99'),
          _buildDealCard(
              'Stylish Sofa', 'https://via.placeholder.com/150', '\$299.99'),
          _buildDealCard(
              'Elegant Table', 'https://via.placeholder.com/150', '\$149.99'),
        ],
      ),
    );
  }

  Widget _buildDealCard(String title, String imageUrl, String price) {
    return Container(
      width: 140,
      margin: EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 120,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
          SizedBox(height: 4),
          Text(
            price,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularItemCard(String imagePath) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 14,
            child:
                Icon(Icons.favorite_border, size: 18, color: Color(0xFF6200EE)),
          ),
        ),
      ),
    );
  }
}
