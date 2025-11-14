import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key, required this.container, required this.title});

  final Container container;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primary,
        appBar: AppBar(
          backgroundColor: primary,
          title: Text(
            title,
            style: title == "Decide." ? Theme.of(context).textTheme.titleLarge : Theme.of(context).textTheme.titleMedium,
          ),
          iconTheme: IconThemeData(
            color: white,
          ),
          shape: Border(
            bottom: BorderSide(
              color: primary,
              width: border,
            )
          ),
        ),
        body: SafeArea(
            child: container,
        ),
      )
    );
  }
}