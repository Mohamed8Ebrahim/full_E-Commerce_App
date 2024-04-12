// ignore_for_file: file_names

import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Cart_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Category_View.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Favorite_View.dart';
import 'package:e_commerce/Core/Shared/Views_Background.dart';
import 'package:e_commerce/Features/Bottom_Navigation_Views/Presentations/Views/Home_View.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});
  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    const HomeView(),
    const CategoryView(),
    const FavoriteView(),
    const CartView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewsBackground(
        child: _tabs[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
