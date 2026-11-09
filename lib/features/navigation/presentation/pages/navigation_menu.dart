import 'package:flutter/material.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../widgets/bottom_navbar.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  //index halaman yg sedang aktif
  int _selectedIndex = 0;

  //simpen halaman yg pernah dibuka
  final Set<int> _visitedPages = {0};

  //pindah halaman saat navbar ditekan
  void _changePage(int index) {
    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
      _visitedPages.add(index);
    });
  }

  Widget _buildPage(int index) {
    if (!_visitedPages.contains(index)) {
      return const SizedBox.shrink();
    }

    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const _TemporaryPage(title: 'Feed');
      case 2:
        return const _TemporaryPage(title: 'Notification');
      case 3:
        return const _TemporaryPage(title: 'Profile');
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //konten pages
      body: IndexedStack(
        index: _selectedIndex,
        children: List.generate(4, _buildPage),
      ),

      //bottom navbar
      bottomNavigationBar: BottomNavbar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _changePage,
      ),
    );
  }
}

//halaman sementara sebelum halaman asli diintegrasikan
class _TemporaryPage extends StatelessWidget {
  final String title;

  const _TemporaryPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),

      body: Center(child: Text('Halaman $title')),
    );
  }
}
