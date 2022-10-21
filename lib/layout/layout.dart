import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/jobs_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../services/user_provider.dart';
import '../utils/colors.dart';

class ResponsiveLayout extends StatefulWidget {
  const ResponsiveLayout({Key? key}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  int _selectedIndex = 0;

  final _pagesOptions = [
    ProfileScreen(
      uid: FirebaseAuth.instance.currentUser!.uid,
    ),
    const JobsScreen(),
    const SearchScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagesOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: backgroundColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Serviços',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Pesquisa",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
