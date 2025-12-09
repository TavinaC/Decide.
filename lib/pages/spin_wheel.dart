import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:confetti/confetti.dart';

import 'package:audioplayers/audioplayers.dart';


class Wheel extends StatelessWidget {
  const Wheel({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Picker Wheel",
      container: Container(
        padding: EdgeInsets.all(2*padding),
        constraints: const BoxConstraints.expand(),
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: white,
          border: Border.all(color: primaryLight, width: border),
          borderRadius: BorderRadius.circular(radius),
          
        ),
        child:SpinWheel()
    ));
  }
}

class SpinWheel extends StatefulWidget {
  const SpinWheel({super.key});

  @override
  State<SpinWheel> createState() => _SpinWheelState();
  
}

class _SpinWheelState extends State<SpinWheel> {

  List<String>items = [
    "Orange", "Lemon", "Lime", "Grapefruit", "Tangerine", "Pomelo"
  ];

  Random random = Random();

  final result = BehaviorSubject<int>();
  BehaviorSubject<int> selected = BehaviorSubject<int>();
  late int prev;

  final confetti = ConfettiController(duration: const Duration(milliseconds: 100));

  late final AudioPlayer player;

  @override
  void initState() async {
    prev = 0;
    player = AudioPlayer();
    await player.setReleaseMode(ReleaseMode.stop);
    await player.setPlayerMode(PlayerMode.lowLatency);
    await player.setSourceAsset('sounds/ticks.mp3');

    super.initState();
  }

  @override
  void dispose() {
    result.close();
    selected.close();
    confetti.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                      SizedBox(
                        height: 7*padding,
                        child: StreamBuilder(
                          stream: selected, 
                          initialData: 0,
                          builder: (context, snapshot) {
                            int result = snapshot.data ?? 0;
                        
                            return Text(
                                items[result],
                                textAlign: TextAlign.center,
                                style: TextStyle(color: getColor(result), fontSize: 32),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                            );
                          }
                        ),
                      ),
                  AspectRatio(
                    aspectRatio: 0.95,
                      child: FortuneWheel(
                        physics: CircularPanPhysics(
                          duration: Duration(seconds: 1),
                          curve: Curves.decelerate,
                        ),
                        onFling: () {
                          result.add(Fortune.randomInt(0, items.length));
                        },
                        onAnimationEnd: () => {
                          confetti.play()
                        },
                        onAnimationStart: () => {
                          player.resume()
                        },
                        onFocusItemChanged: (value) => {
                          selected.add(value)
                        },
                        selected: result.stream,
                        animateFirst: false,
                        items: [
                          for(int i = 0; i < items.length; i ++)...<FortuneItem> {
                            FortuneItem(
                              child: Padding(
                                padding: EdgeInsets.only(left:4*padding, right: 2*padding),
                                child: Text(
                                  items[i].toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.dynaPuff(
                                    color: white,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              style: FortuneItemStyle(
                                color: getColor(i),
                                borderColor: primaryLight,
                                borderWidth: 2*padding/3,
                              )
                            )
                          }
                        ],
                        indicators: [
                          FortuneIndicator(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: 4*padding,
                              width: 3*padding,
                              child: CustomPaint(
                                painter: TrianglePainter(),
                              ),
                            )
                          )
                        ],
                      ),
                  ),
                  Text(
                      "Swipe to Spin!",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: primary, fontSize: 32),
                  ),
                ],
              ),
            ),
            ConstrainedBox(
                  constraints: BoxConstraints.tightFor(height: 6*padding),
                  child: ElevatedButton(
                    onPressed: () {
                      //function
                    },
                    style: ElevatedButton.styleFrom(
                      overlayColor: primaryDark,
                      backgroundColor: primary,
                      shadowColor: primaryDark,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(radius),
                        side:BorderSide(
                          width: border,
                          color: primaryLight
                        )
                      ),
                      padding: EdgeInsets.all(padding),
                    ),
                    child: Text("Edit Items", style: GoogleFonts.dynaPuff(color: white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2))),
                )
          ],
        ),
        ConfettiWidget(
          confettiController: confetti,
          blastDirectionality: BlastDirectionality.explosive, //down
          shouldLoop: false,
          emissionFrequency: 1,
          numberOfParticles: 10,
          minBlastForce: 30,
          maxBlastForce: 31,
          gravity: 0.7,
        ),
      ],
    );
  }

  Color getColor(int index) {
    if (index%3 == 0) {
      if (index == 0 && items.length%3 == 1) {
        return wheel3;
      }
      return primary;
    } else if (index%3 == 1) {
      return wheel2;
    } else {
      return wheel3;
    }
  }
  
}

class TrianglePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = primaryDark
    ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = primaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = padding/2;

    final path = Path();
    path.moveTo(0, 0); // Bottom left
    path.lineTo(size.width, 0); // Bottom right
    path.lineTo(size.width / 2, size.height); // Top center
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}