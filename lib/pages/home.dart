import 'package:decide2/components/base_page.dart';
import 'package:decide2/components/home_buttons.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<String> buttons = [
    'Number Generator',
    'Coin Flip',
    'Dice Roll',
    'Wheel Selector',
  ];

  static const List<String> routes = ['/rng', '/coin', '/dice', '/wheel'];

  static const List<String> images = [
    'assets/rng.png',
    'assets/coin.png',
    'assets/dice.png',
    'assets/wheel.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Decide.",
      container: Container(
        padding: EdgeInsets.all(padding),
        child: Column(
          spacing: padding,
          children: [
            Expanded(
              child: Row(
                spacing: padding,
                children: [
                  HomeButtons(
                    text: buttons[0],
                    route: routes[0],
                    img: images[0],
                  ),
                  HomeButtons(
                    text: buttons[1],
                    route: routes[1],
                    img: images[1],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                spacing: padding,
                children: [
                  HomeButtons(
                    text: buttons[2],
                    route: routes[2],
                    img: images[2],
                  ),
                  HomeButtons(
                    text: buttons[3],
                    route: routes[3],
                    img: images[3],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
