import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

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
          border: Border.all(color: primaryLight, width: border),
          borderRadius: BorderRadius.circular(radius),
        ),

        child: CoinWidgetManager(),
      ),
    );
  }
}

class FlipCoinController {
  _CoinState? _state;

  Future flipCoin() async => _state?.flipCoin();
}

class CoinWidgetManager extends StatefulWidget {
  const CoinWidgetManager({super.key});

  @override
  State<CoinWidgetManager> createState() => _CoinWidgetManager();
}

class _CoinWidgetManager extends State<CoinWidgetManager>
    with SingleTickerProviderStateMixin {
  final FlipCoinController controller = FlipCoinController();

  Vector3 direction = Vector3(1.0, 0.0, 0.0);
  Offset? startPosition;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1300),
    );

    /*_controller.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse(); // Reverse when animation completes
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward(); // Play forward when animation returns to start
    }});*/

    _animation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Apply the ease-in-out curve
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart: (details) {
        startPosition = details.globalPosition;
      },
      onPanEnd: (details) async {
        if (startPosition != null) {
          // Calculate the difference in screen coordinates
          final dx = details.globalPosition.dx - startPosition!.dx;
          final dy = details.globalPosition.dy - startPosition!.dy;

          setState(() {
            direction = Vector3(dy, -dx, 0.0).normalized();
          });
        }
        _controller.forward().then((_) {
          _controller.reverse();
        });
        await controller.flipCoin();
      },
      onTap: () async {
        setState(() {
          direction = Vector3(1.0, 0.0, 0.0);
        });
        _controller.forward().then((_) {
          _controller.reverse();
        });
        await controller.flipCoin();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ScaleTransition(
            scale: _animation,
            child: Container(
              padding: EdgeInsets.all(2 * padding),
              child: FittedBox(
                fit: BoxFit.contain,
                child: CoinWidget(
                  heads: Image.asset('assets/coin_head.png'),
                  tails: Image.asset('assets/coin_tail.png'),
                  controller: controller,
                  direction: direction,
                ),
              ),
            ),
          ),
          Container(
            height: 6 * padding,
            margin: EdgeInsets.all(padding),
            child: Center(
              child: Text(
                "Swipe to Flip",
                style: TextStyle(color: primary, fontSize: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoinWidget extends StatefulWidget {
  const CoinWidget({
    super.key,
    required this.heads,
    required this.tails,
    required this.controller,
    required this.direction,
  });

  final Image heads;
  final Image tails;
  final FlipCoinController controller;
  final Vector3 direction;

  @override
  State<CoinWidget> createState() => _CoinState();
}

class _CoinState extends State<CoinWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isHeads = true;
  //double anglePlus = 0;
  late int times = 5;
  int animationCount = 0;
  late bool outcome = Random().nextBool();
  late bool doHalf = false;

  Future flipCoin() async {
    animationCount = 0;
    outcome = Random().nextBool();

    if (controller.isAnimating) return;
    await controller.forward(from: 0);

    /*for (int i = 1; i <= times; i++) {
      if(controller.isAnimating) return;
      isHeads = !isHeads;

      //ease in and out 
      double duration = i <= times/2 
        ? (-32*pow(2*i/times, 3)+5)*80
        : (-32/pow(times, 3)*pow(times-1.5*i, 3)+5)*80;

      if (duration <= 150) {
        duration = 150;
      }
        
      //controller.duration = Duration(milliseconds: duration.toInt());
      //await controller.forward(from:0).then((value) => anglePlus = pi);
    }*/
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(widget.heads.image, context);
      precacheImage(widget.tails.image, context);
    });

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 214),
    );

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (animationCount < times) {
          animationCount++;
          double duration = animationCount <= times / 2
              ? 214
              : (-32 / pow(times, 3) * pow(times - 1.5 * animationCount, 3) +
                        5) *
                    80;

          if (duration <= 150) {
            duration = 150;
          }

          controller.duration = Duration(milliseconds: duration.toInt());
          if (animationCount == times) {
            doHalf = outcome;
          } //else if (!isHeads && animationCount < 1) {
          //await controller.forward(from:0.5); }
          else {
            doHalf = false;
          }
          await controller.forward(from: 0);
        }
      }
    });

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
        double angle = 0;
        bool mybool = !isHeads && controller.value < 0.5 && animationCount < 1;
        if (mybool) {
          angle = pi;
          doHalf = true;
        }
        angle = doHalf
            ? controller.value * pi + angle
            : controller.value * 2 * pi + angle;
        //double angle = controller.value*2*pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotate(widget.direction, angle);

        //print("$controller.value $isHeads $mybool $angle");

        isHeads = (angle.abs() <= pi / 2 || angle.abs() >= 3 * pi / 2);

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: //widget.heads//display front or back depending on angle
          ((angle.abs() < pi / 2 || angle.abs() > 3 * pi / 2))
              ? widget.heads
              : //widget.tails
                /*Tails(
              tails: widget.tails,
              direction: widget.direction,
              angle: angle,
              )*/
                Transform(
                  transform: Matrix4.identity()..rotate(widget.direction, pi),
                  alignment: Alignment.center,
                  child: widget.tails,
                ),
          /**/
        );
      },
    );
  }
}

class Tails extends StatefulWidget {
  final Image tails;
  final Vector3 direction;
  final double angle;

  const Tails({
    super.key,
    required this.tails,
    required this.direction,
    required this.angle,
  });

  @override
  State<StatefulWidget> createState() => _TailsState();
}

class _TailsState extends State<Tails> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotate(widget.direction, pi),
      alignment: Alignment.center,
      child: widget.tails,
    );
  }
}
