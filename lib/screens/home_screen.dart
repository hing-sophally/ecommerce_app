import 'dart:async';
import 'package:flutter/material.dart';
import 'package:testing/screens/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required String user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<String> images = [
    'https://vibrantskinbar.com/wp-content/uploads/best-natural-skin-care-routine.jpg',
    'https://www.getrael.com/cdn/shop/articles/December_Blog_Banners_Benefits_of_Organic_Skin_Care_Products.png?v=1641404707',
    'https://www.bellobello.my/wp-content/uploads/2022/08/boldlipessentials-2.jpg',
  ];

  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.face, 'label': 'Face'},
    {'icon': Icons.favorite, 'label': 'Favorites'},
    {'icon': Icons.spa, 'label': 'Spa'},
    {'icon': Icons.wb_sunny, 'label': 'Sun Care'},
    {'icon': Icons.clean_hands, 'label': 'Hand Care'},
    {'icon': Icons.ac_unit, 'label': 'Cooling'},
    {'icon': Icons.water_drop, 'label': 'Hydrate'},
    {'icon': Icons.local_florist, 'label': 'Natural'},
    {'icon': Icons.star, 'label': 'Best'},
    {'icon': Icons.more_horiz, 'label': 'More'},
  ];

  final List<Map<String, dynamic>> products = [
    {
      'title': 'Natural Face Cream',
      'price': 25.0,
      'image':
      'https://images.unsplash.com/photo-1542831371-d531d36971e6?auto=format&fit=crop&w=500&q=60', // Face cream image
    },
    {
      'title': 'Organic Serum',
      'price': 40.0,
      'image':
      'https://moonglow.md/wp-content/uploads/2022/07/mary_may__cica_houttuynia_tea_tree_calming_mask-_-1655200891.webp', // Serum image (kept original, looks like skincare serum)
    },
    {
      'title': 'Hydrating Lotion',
      'price': 18.5,
      'image':
      'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=500&q=60', // Lotion image
    },
    {
      'title': 'Sun Protection',
      'price': 30.0,
      'image':
      'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?auto=format&fit=crop&w=500&q=60', // Sunscreen image
    },
    {
      'title': 'Soothing Spa Oil',
      'price': 22.0,
      'image':
      'https://www.dreamskinnepal.com/Assets/Product/Media/Images/Product%20Images/2024/06/61aJI2sY6AL._SL1500_.jpg', // Spa oil image
    },
    {
      'title': 'Cooling Gel',
      'price': 15.0,
      'image':
      'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=500&q=60', // Cooling gel image
    },
  ];

  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Auto slide timer
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffce8f4), // soft pink page background
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: CustomScrollView(
          slivers: [
            // Sliver AppBar
            SliverAppBar(
              pinned: true,
              leading: SizedBox.shrink(),
              backgroundColor: const Color(0xffe17ffa),
              expandedHeight: 70.0,
              flexibleSpace: const FlexibleSpaceBar(
                title: Text(
                  'BEE SKIN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                titlePadding: EdgeInsets.only(left: 16, bottom: 16),

              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.account_circle, color: Colors.white),
                  onPressed: () {
                    // Navigate to UserProfile page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfile(user: {},)),
                    );
                  },
                ),
              ],

            ),

            // Banner Slider
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Category Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: const Color(0xffe17ffa),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  category['icon'],
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                category['label'],
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff333333),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),

            // Products Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    final product = products[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image with heart icon overlay
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  product['image'],
                                  height: 120,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.7),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Title and price
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            child: Text(
                              product['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '\$${product['price'].toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Add to Cart button
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xffe17ffa),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                                onPressed: () {
                                  print('Add to cart: ${product['title']}');
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: products.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.68,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
