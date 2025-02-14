import 'package:flutter/material.dart';
import 'package:tiny_gift/view/pages/components/drawer_menu.dart';
import 'package:tiny_gift/view/pages/home_page.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/rendering.dart';

import 'components/custom_theme.dart';

 class NavigationScreen extends StatefulWidget {
  final IconData iconData;

  const NavigationScreen(this.iconData, {super.key});

  @override
  _NavigationScreenState createState() {
    return _NavigationScreenState();
  }
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.iconData != widget.iconData) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).extension<CustomColorsTheme>()!;
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: ListView(
        children: [
          SizedBox(height: 64),
          Center(
            child: CircularRevealAnimation(
              animation: animation,
              centerOffset: Offset(80, 80),
              maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
              child: Icon(
                widget.iconData,
                color: Colors.green,
                size: 160,
              ),
            ),
          ),
        ],
      ),
    );
  }
}