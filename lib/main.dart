import 'package:flutter/material.dart';
import 'package:learn/config/localDB.dart';
import 'package:learn/config/routes.dart';
import 'package:learn/providers/authVM.dart';
import 'package:learn/providers/cartVM.dart';
import 'package:learn/providers/deal_of_dayVM.dart';
import 'package:learn/providers/promobannerVM.dart';
import 'package:learn/views/user/authentication/authScreen.dart';
import 'package:learn/views/user/cart/cartScreen.dart';
import 'package:learn/views/user/product/categorybyProduct.dart';
import 'package:learn/views/user/product/favoriteScreen.dart';
import 'package:learn/views/user/orders/orderHistoryScreen.dart';
import 'package:learn/views/user/product/product_detalScreen.dart';
import 'package:learn/views/user/authentication/profileScreen.dart';
import 'package:learn/providers/homeVM.dart';
import 'package:learn/views/user/promo_banner/promobannerlist_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Fetch token and user type
  final token = await LocalDatabaseService()
      .fromDb(await LocalDatabaseService().openBox("token"), 'key');
  final userType = await LocalDatabaseService()
      .fromDb(await LocalDatabaseService().openBox("type"), 'key');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AuthVM()),
        ChangeNotifierProvider(create: (_) => CartVM()),
        ChangeNotifierProvider(create: (_) => PrromoBannerVM()),
        ChangeNotifierProvider(create: (_) => DealOFDayVM()),
      ],
      child: HomePageApp(savedToken: token, userType: userType),
    ),
  );
}

class HomePageApp extends StatelessWidget {
  final String? savedToken;
  final String? userType;

  const HomePageApp({super.key, this.savedToken, this.userType});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(),
      ),
      home: SplashScreen(savedToken: savedToken, userType: userType),
      initialRoute: '/',
      onGenerateRoute: generateRoute,
    );
  }
}

class SplashScreen extends StatelessWidget {
  final String? savedToken;
  final String? userType;

  const SplashScreen({super.key, this.savedToken, this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeApp(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'An error occurred: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }

          return const SizedBox.shrink(); // Shouldn't reach here
        },
      ),
    );
  }

  Future<void> _initializeApp(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (savedToken != null) {
        if (userType == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AdminHomePage()),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const UserHomePage()),
          );
        }
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AuthPage()),
        );
      }
    });
  }
}

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  size: 24,
                ),
                label: ['Home', 'Favorite', 'Profile', 'Cart'][index],
              );
            },
          ),
        );
      }),
    );
  }
}

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Similar structure as AdminHomePage or customize as needed
    return const Center(child: Text("User Home Page"));
  }
}

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';
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
              buildCategoryList(context),
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

// Display Categories Dynamically with Horizontal Scrolling
  Widget buildCategoryList(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isloading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.error != null) {
          return Center(child: Text('Error: ${provider.error}'));
        }

        if (provider.categoriesList.isEmpty) {
          return const Center(child: Text('No categories available'));
        }

        // Wrap the Row in a SingleChildScrollView for horizontal scrolling
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: provider.categoriesList
                .map(
                  (category) => GestureDetector(
                    onTap: () {
                      // Handle category click
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryItemsScreen(
                            categoryId: category.id.toString(),
                            categoryName: category.name,
                          ),
                        ),
                      );
                    },
                    child: _buildCategoryCard(
                      category.name ??
                          'Unknown', // Ensure null safety for title
                      Icons.category, // Use a default icon for categories
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
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
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Consumer<PrromoBannerVM>(
      builder: (context, vm, child) {
        if (vm.isloading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (vm.error != null) {
          return Center(
            child: Text(
              vm.error!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (vm.pbannerList.isEmpty) {
          return const Center(child: Text("No promotions available."));
        }

        // Display the first promo banner and 'See All' button
        final banner = vm.pbannerList.first;
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      8), // Rounded corners for the container
                  color: Colors.grey[200], // White background for a clean look
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
                              banner.title ?? 'No Title',
                              style: const TextStyle(
                                fontSize: 14, // Smaller font size for the title
                                fontWeight: FontWeight.bold,
                                color: Colors
                                    .black87, // Darker color for the title
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              banner.description ?? 'No Description',
                              style: const TextStyle(
                                fontSize:
                                    12, // Smaller font size for the description
                                fontWeight: FontWeight.normal,
                                color: Colors
                                    .red, // Red for description to make it pop
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const PromoBannerListPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'See all items',
                                style: TextStyle(
                                  color: Colors
                                      .blue, // Blue for the "See All" button
                                  fontSize:
                                      14, // Slightly smaller font size for the button text
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              16), // Rounded corners for the image
                          child: Image.network(
                            banner.imageUrl ?? '',
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDealsSection() {
    return Consumer<DealOFDayVM>(
      builder: (context, dealOFDayVM, child) {
        // Check if data is loading or there's an error
        if (dealOFDayVM.isloading) {
          return Center(child: CircularProgressIndicator());
        }

        if (dealOFDayVM.error != null) {
          return Center(child: Text('Error: ${dealOFDayVM.error}'));
        }

        if (dealOFDayVM.dealdayList.isEmpty) {
          return Center(child: Text('No Deals Available'));
        }

        // If deals are available, display them in the ListView
        return Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dealOFDayVM.dealdayList.length,
            itemBuilder: (context, index) {
              final deal = dealOFDayVM.dealdayList[index];

              // Build each deal card using the data from the ViewModel
              return _buildDealCard(
                deal.productName ?? 'Unknown Item',
                'https://via.placeholder.com/150',
                '\$${deal.price ?? '0.00'}', // If price is missing, show 0.00
              );
            },
          ),
        );
      },
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
