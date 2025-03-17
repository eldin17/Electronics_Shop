import 'package:flutter/material.dart';
import 'package:flutter17_mobile/helpers/icons.dart';
import 'package:flutter17_mobile/screens/home2.dart';
import 'package:flutter17_mobile/screens/home_screen.dart';
import 'package:flutter17_mobile/screens/login_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

const Color inActiveIconColor = Color(0xFFB6B6B6);

class MasterScreen extends StatefulWidget {
  //Widget child;
  int index;

  MasterScreen(
      {super.key,
      //required this.child,
      required this.index});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  int currentSelectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateCurrentIndex(widget.index);
  }

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
    // if (index == 2) {
    //   Navigator.of(context).push(
    //     PageRouteBuilder(
    //       transitionDuration: Duration.zero,
    //       pageBuilder: (context, animation, secondaryAnimation) =>
    //           HomeScreen2(),
    //     ),
    //   );
    // }
  }

  // final pages = [
  //   const Center(
  //     child: HomeScreen(),
  //   ),
  //   const Center(
  //     child: HomeScreen2(),
  //   ),
  //   const Center(
  //     child: Text("Cart"),
  //   ),
  //   const Center(
  //     child: Text("Profile"),
  //   ),
  // ];
  final pages = [
    () => const HomeScreen(),
    () => const Center(child: Text("Wishlist")),
    () => const Center(child: Text("Cart")),
    //() => const Center(child: Text("Notifications")),
    () => const HomeScreen2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: widget.child!,
      // ),
      body: pages[currentSelectedIndex](),
      bottomNavigationBar: BottomNavigationBar(
        onTap: updateCurrentIndex,
        currentIndex: currentSelectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              homeIcon,
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.string(
              homeIcon,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFF7643),
                BlendMode.srcIn,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              heartIcon,
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.string(
              heartIcon,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFF7643),
                BlendMode.srcIn,
              ),
            ),
            label: "Fav",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              chatIcon,
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.string(
              chatIcon,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFF7643),
                BlendMode.srcIn,
              ),
            ),
            label: "Chat",
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.string(
          //     countryIcon,
          //     colorFilter: const ColorFilter.mode(
          //       inActiveIconColor,
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   activeIcon: SvgPicture.string(
          //     countryIcon,
          //     colorFilter: const ColorFilter.mode(
          //       Color(0xFFFF7643),
          //       BlendMode.srcIn,
          //     ),
          //   ),
          //   label: "Notifications",
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.string(
              userIcon,
              colorFilter: const ColorFilter.mode(
                inActiveIconColor,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.string(
              userIcon,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFF7643),
                BlendMode.srcIn,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
