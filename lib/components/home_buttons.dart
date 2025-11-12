import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget{

  final String text;
  final String route;

  const HomeButtons({super.key, required this.text, required this.route});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Padding(
      padding: EdgeInsets.all(padding),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: primary,
              width: border,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Text(text, style: TextStyle(color: black)))
          )
      )
    );
  }
}