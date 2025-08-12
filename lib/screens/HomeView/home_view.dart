import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80), // Space for bottom nav
          child: Consumer<HomeController>(
            builder: (context, homeController, _) {
              return Column(
                children: [
                  _buildHeader(),
                  _buildSpecialOffer(),
                  _buildCategories(homeController),
                  _buildProductGrid(homeController),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16), // Reduced from 20
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Sharath',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              Text(
                'What do you want to eat?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Spacer(),
          CircleAvatar(
            backgroundColor: Colors.orange.shade100,
            child: Icon(Icons.person, color: Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialOffer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Reduced margins
      padding: EdgeInsets.all(12), // Reduced from 16
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order special\nExclusive Offer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Get 25% discount',
                  style: TextStyle(color: Colors.orange),
                ),
              ],
            ),
          ),
          Text('🍔', style: TextStyle(fontSize: 50)),
        ],
      ),
    );
  }

  Widget _buildCategories(HomeController homeController) {
    return Container(
      height: 100, // Reduced from 120
      padding: EdgeInsets.symmetric(vertical: 10), // Reduced from 20
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16), // Reduced from 20
        itemCount: homeController.categories.length,
        itemBuilder: (context, index) {
          final category = homeController.categories[index];
          final isSelected = category == homeController.selectedCategory;

          return GestureDetector(
            onTap: () => homeController.selectCategory(category),
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.orange : Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _getCategoryEmoji(category),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.orange : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(HomeController homeController) {
    final products = homeController.filteredProducts;

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(), // Prevent nested scrolling
      padding: EdgeInsets.all(16), // Reduced from 20
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85, // Adjusted from 0.8 for shorter items
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Center(
                    child: Text(
                      product.image,
                      style: TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 16),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'All':
        return '🍽️';
      case 'Burger':
        return '🍔';
      case 'Pizza':
        return '🍕';
      case 'Drinks':
        return '🥤';
      case 'Dessert':
        return '🍦';
      default:
        return '🍽️';
    }
  }
}