import 'package:flutter/material.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const[
          NavigationDestination(
            icon: Icon(Icons.home), 
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.dynamic_feed), 
            label: 'Feed',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt), 
            label: 'History',
          ),   
          NavigationDestination(
            icon: Icon(Icons.person), 
            label: 'Profile',
          ),       
        ],
      ),
    );
  }
}