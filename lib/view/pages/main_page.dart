import 'package:flutter/material.dart';
import 'package:tiny_gift/view/pages/components/drawer_menu.dart';
import 'package:tiny_gift/view/pages/home_page.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/rendering.dart';

import 'components/custom_theme.dart';
import 'navigation_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>  with TickerProviderStateMixin {

  final autoSizeGroup = AutoSizeGroup();
  int _selectedIndex = 0;

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <IconData>[
    Icons.home,
    // Icons.search,
    // Icons.history,
    Icons.person,
  ];

  final bottomList = <String>[
    "Home",
    // "Search",
    // 'History',
    'Profile',
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(title: "Home"),
    // Text('Search'),
    // Text('History'),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

     _fabAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _borderRadiusAnimationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      Duration(seconds: 1),
      () => _fabAnimationController.forward(),
    );
    Future.delayed(
      Duration(seconds: 1),
      () => _borderRadiusAnimationController.forward(),
    );
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      endDrawer: DrawerPage(),
      // body: Center(
      //   child: _widgetOptions.elementAt(_selectedIndex),
      // ),
      body: NotificationListener<ScrollNotification>(
        onNotification: onScrollNotification,
        //child: NavigationScreen(iconList[_selectedIndex]),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle, // Circle shape
          border: Border.all(color: Colors.white, width: 4), // Optional border
        ),
        child: FloatingActionButton(
          onPressed: () {
            _fabAnimationController.reset();
            _borderRadiusAnimationController.reset();
            _borderRadiusAnimationController.forward();
            _fabAnimationController.forward();
          },
          backgroundColor: Colors.transparent, // Transparent background inside the circle
          child: Icon(Icons.edit_document),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive
              ? Colors.green
              : Colors.white;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: AutoSizeText(
                  bottomList[index],
                  maxLines: 1,
                  style: TextStyle(color: color),
                  group: autoSizeGroup,
                ),
              )
            ],
          );
        },
        backgroundColor: Colors.black,
        activeIndex: _selectedIndex,
        splashColor: Colors.blue,
        notchAndCornersAnimation: borderRadiusAnimation,
        splashSpeedInMilliseconds: 300,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _selectedIndex = index),
        hideAnimationController: _hideBottomBarAnimationController,
        shadow: BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.green,
        ),
      ),
      
      
      // BottomNavigationBar(
      //   backgroundColor: Colors.black,
      //   selectedItemColor: Colors.green,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       backgroundColor: Colors.black
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //       backgroundColor: Colors.black
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.history),
      //       label: 'History',
      //       backgroundColor: Colors.black
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //       backgroundColor: Colors.black
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
