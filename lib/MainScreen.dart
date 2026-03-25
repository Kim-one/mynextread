import 'package:flutter/material.dart';
import 'package:mynextread/pages/home.dart';
import 'package:mynextread/pages/profile.dart';
import 'package:mynextread/widgets/bottomNavBar.dart';
import 'package:mynextread/widgets/library_tabs.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const LibraryTabs(),
    const ProfileWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        leading: Icon(
          Icons.auto_stories,
          color: Colors.pink.shade200,
          size: 35.0,
        ),
        title: Text(
          'My Next Read',
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          Icon(
            Icons.settings,
            color: Theme.of(context).colorScheme.primary,
            size: 35.0,
          )
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavBar(
          selectedIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
      ),
    );
  }
}