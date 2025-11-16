import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';

class Coin extends StatelessWidget {
  const Coin({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Coin Flip",
      container: Container(
        constraints: const BoxConstraints.expand(),
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            color: white,
            border: Border.all(
              color: primaryLight,
              width: border,
            ),
            borderRadius: BorderRadius.circular(radius),
        ),

        child: CoinWidgetManager()
    ));
  }
}

class FlipCoinController {

  _CoinState? _state;

  Future flipCoin() async => _state?.flipCoin();
}

class CoinWidgetManager extends StatelessWidget{
  CoinWidgetManager({super.key});

  final FlipCoinController controller = FlipCoinController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () async {
        int times = Random().nextBool() ? 10 : 11;
        for (var i = 0; i < times; i++) {
          await controller.flipCoin();
        }
      },
      child: Container (
        padding: EdgeInsets.all(2*padding),
        child: FittedBox(
        fit: BoxFit.contain,
        child: CoinWidget(
        heads: Image.asset('assets/coin_head.png'), 
        tails: Image.asset('assets/coin_tail.png'),
        controller: controller,
      ),
      ))
    );
  }
}

class CoinWidget extends StatefulWidget{
  
  const CoinWidget({super.key, required this.heads, required this.tails, required this.controller});

  final Image heads;
  final Image tails;
  final FlipCoinController controller;


  @override
  State<CoinWidget> createState() => _CoinState();
  
}

class _CoinState extends State<CoinWidget> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  bool isHeads = true;
  double anglePlus = 0;

  Future flipCoin() async {
    if(controller.isAnimating) return;
    isHeads = !isHeads;

    await controller.forward(from:0).then((value) => anglePlus = pi);
  }
  
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(widget.heads.image, context);
      precacheImage(widget.tails.image, context);
    });

    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    widget.controller._state = this;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller, 
      builder: (context, child) {
        double angle = controller.value * pi;
        if(isHeads) angle += anglePlus;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(angle);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: //display front or back depending on angle
            (angle.abs() <= pi/2 || angle.abs() >= 3*pi/2)
            ? widget.heads
            : Transform(
              transform: Matrix4.identity()..rotateX(pi),
              alignment: Alignment.center,
              child: widget.tails,)
          
        );
      }
    ); 
  }
}


