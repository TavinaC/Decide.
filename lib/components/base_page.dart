import 'package:decide2/components/app_bar.dart';
import 'package:decide2/styles/colors.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.container, required this.title});

  final Container container;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: Bar(title: title,),
      body: Column(
        children: [Expanded(
          child: container,
        )]
      )
    );
  }
}