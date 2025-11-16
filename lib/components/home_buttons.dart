import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget{

  final String text;
  final String route;
  final String img;

  const HomeButtons({super.key, required this.text, required this.route, required this.img});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
        Navigator.pushNamed(context, route);
      },
        child: Container(
          decoration: BoxDecoration(
            color: white,
            border: Border.all(
              color: primaryLight,
              width: border,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded ( 
                  child: Container(
                  padding: EdgeInsetsGeometry.all(padding),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(img),
                    )
                  ),
                ),
                Padding (
                  padding: EdgeInsetsGeometry.only(bottom: 2*padding),
                  child: Text(text, textAlign: TextAlign.center,),
                )
                ],
              )
          )
      )
    ));
  }
}