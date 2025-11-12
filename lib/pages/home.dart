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
    'Choice Wheel',
  ];

  static const List<String> routes = [
    '/rng',
    '/coin',
    '/dice',
    '/wheel',
  ];
  
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Decide.",
      container: Container(
        padding: EdgeInsets.only(left:padding, right:padding, bottom: padding),
          child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), 
            itemBuilder: (BuildContext context, int index) {
              return HomeButtons(
                text: buttons[index],
                route: routes[index],
                );
            })
    ));
}}