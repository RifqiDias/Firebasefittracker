import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebasefittracker/page/chart_page.dart';
import 'package:firebasefittracker/page/profile_page.dart';
import 'package:firebasefittracker/page/tracking_firestore.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            AddToFirestore(),
            ChartPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: const Text('Home'), icon: const Icon(Icons.home)),
          BottomNavyBarItem(title: const Text('Chart'), icon: const Icon(Icons.bar_chart_sharp)),
          BottomNavyBarItem(title: const Text('Profile'), icon: const Icon(Icons.person)),
        ],
      ),
    );
  }
}
