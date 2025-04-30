import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/models/shopping_cart.dart';
import 'package:flutter17_mobile/screens/profile_screen.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/shopping_cart_screen.dart';
import 'package:flutter17_mobile/screens/wishlist_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class MasterScreen extends StatefulWidget {
  int index;

  MasterScreen({super.key, required this.index});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int currentSelectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final Map<int, Widget> _pages = {};

  @override
  void initState() {
    super.initState();
    currentSelectedIndex = widget.index;
  }

  void _onItemTapped(int index) {
    if (index == currentSelectedIndex && index == 1) {
      print("EVOMEEEEE test");
    } else if (index == currentSelectedIndex) {
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  Widget _buildPage(int index) {
    if (_pages.containsKey(index)) return _pages[index]!;

    late Widget page;
    switch (index) {
      case 0:
        page = Navigator(
          key: _navigatorKeys[0],
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => HomeScreen(),
          ),
        );
        break;
      case 1:
        page = Navigator(
          key: _navigatorKeys[1],
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => WishlistScreen(),
          ),
        );
        break;
      case 2:
        page = Navigator(
          key: _navigatorKeys[2],
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (_) => ShoppingCartScreen(),
          ),
        );
        break;
      case 3:
        page = ProfileScreen();
        break;
      default:
        page = HomeScreen();
        break;
    }

    _pages[index] = page;
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(currentSelectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.string(homeIcon, colorFilter: const ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            activeIcon: SvgPicture.string(homeIcon, colorFilter: const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn)),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(heartIcon, colorFilter: const ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            activeIcon: SvgPicture.string(heartIcon, colorFilter: const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn)),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(chatIcon, colorFilter: const ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            activeIcon: SvgPicture.string(chatIcon, colorFilter: const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn)),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(userIcon, colorFilter: const ColorFilter.mode(inActiveIconColor, BlendMode.srcIn)),
            activeIcon: SvgPicture.string(userIcon, colorFilter: const ColorFilter.mode(Color(0xFFFF7643), BlendMode.srcIn)),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
