import 'package:classifield_app/screens/add_screen.dart';
import 'package:classifield_app/screens/chat_screen.dart';
import 'package:classifield_app/screens/home_screen.dart';
import 'package:classifield_app/screens/profile_screen.dart';
import 'package:classifield_app/screens/sign_up_screen.dart';
import 'package:classifield_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int selectedBottomBar = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const ChatScreen(),
    const AddScreen(),
    const ProfileScreen(),
  ];
  List bottomBarItems = [
    {
      'icon': const Icon(Icons.home_outlined),
      'activeIcon': const Icon(Icons.home),
      'label': 'Home'
    },
    {
      'icon': const Icon(Icons.message_outlined),
      'activeIcon': const Icon(Icons.message),
      'label': 'Chat'
    },
    {
      'icon': const Icon(Icons.add),
      'activeIcon': const Icon(Icons.add),
      'label': 'Add'
    },
    {
      'icon': const Icon(Icons.person_pin_circle_outlined),
      'activeIcon': const Icon(Icons.person_pin),
      'label': 'Profile'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        currentIndex: selectedBottomBar,
        onTap: (value) {
          setState(() {
            selectedBottomBar = value;
          });
        },
        items: List.generate(
          bottomBarItems.length,
          (index) => BottomNavigationBarItem(
            icon: bottomBarItems[index]['icon'],
            activeIcon: bottomBarItems[index]['activeIcon'],
            label: bottomBarItems[index]['label'],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthServices().signOut();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedBottomBar,
        children: screens,
      ),
    );
  }
}
