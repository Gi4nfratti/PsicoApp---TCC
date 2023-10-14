import 'package:flutter/material.dart';
import 'package:psicoapp/views/action/action_page.dart';
import 'package:psicoapp/views/home_page.dart';
import 'package:psicoapp/views/settings/profile_page.dart';
import 'package:psicoapp/views/psychoeducation/psychoeducation_page.dart';

class TabsWidget extends StatefulWidget {
  const TabsWidget({super.key});

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _selectedPage = [
    HomePage(),
    PsychoeducationPage(),
    ActionPage(),
    ProfilePage(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _selectedPage.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_rounded, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.run_circle_rounded, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 40),
            label: '',
          ),
        ],
        selectedLabelStyle: TextStyle(fontSize: 0),
        unselectedLabelStyle: TextStyle(fontSize: 0),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlue.shade200,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue.shade400,
        onTap: _onItemTapped,
      ),
    );
  }
}
