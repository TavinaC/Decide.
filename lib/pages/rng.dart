import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class RNG extends StatelessWidget {
  const RNG({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Number Generator",
      container: Container(
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(
              color: primaryLight,
              width: border,
            ),
            borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child:Text("Enter a Range:")),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Min:"),
            ],),
            Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Max:"),
            ],),
            Expanded(
              child: Center (
                child: NumberGenerator(),
              )
            )
          ],
        )
    ));
  }
}

class NumberGenerator extends StatefulWidget{
  
  const NumberGenerator({super.key, this.num1, this.num2});
  final dynamic num1;
  final dynamic num2;

  @override
  State<NumberGenerator> createState() => _NumberGenerator();
  
}

class _NumberGenerator extends State<NumberGenerator> {
  

  @override
  Widget build(BuildContext context) {
    return Text("", textAlign: TextAlign.center, style: TextStyle(fontSize: 60),);
  }

}

