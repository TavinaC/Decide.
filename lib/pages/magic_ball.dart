import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class MagicBall extends StatelessWidget {
  const MagicBall({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Magic 8 Ball",
      container: Container(
        constraints: const BoxConstraints.expand(),
        padding: EdgeInsets.all(2*padding),
        margin: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: black,
          border: Border.all(color: greyDark, width: border),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: MagicBallManager(),
      ),
    );
  }
}

class MagicBallManager extends StatefulWidget {
  const MagicBallManager({super.key});

  @override
  State<MagicBallManager> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBallManager>
    with SingleTickerProviderStateMixin {
  String answer = "";
  late int index;
  bool _visible = true;

  List<String> answerList = ["Yes", "No", "Better Luck \nNext Time"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(Object context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onPanStart:(details) {
        setState(() {
          _visible = false;
        });
      },
      onPanEnd: (details) async {
        index = Random().nextInt(answerList.length);
        answer = answerList[index];
        setState(() {
          _visible = true;
        });

      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 8*padding,),
          Expanded(
            /*child: ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 3*padding),
                alignment: Alignment.topCenter,
                color: blue,
                    child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      answer,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.pixelifySans(
                        color: white,
                        fontWeight: FontWeight.normal,
                        fontSize: 28
                        ),
                      softWrap: true,
                    ),
                    ),
              ),
            ),*/
            child: AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: _visible ? const Duration(milliseconds: 500): const Duration(milliseconds: 100),
              child: CustomPaint(
              painter: TrianglePainter(text:answer),
            ))
          ),
          Container(
            height: 6 * padding,
            margin: EdgeInsets.all(padding),
            child: Center(
              child: Text(
                "Shake Me!",
                style: TextStyle(color: white, fontSize: 32),
              ),
            ),
          ),
          SizedBox(height: 2*padding,),
        ],
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0); // Bottom left
    path.lineTo(size.width, 0); // Bottom right
    path.lineTo(size.width / 2, size.width); // Top center
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class TrianglePainter extends CustomPainter {
  String text;

  TrianglePainter({required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = blue
    ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // Bottom left
    path.lineTo(size.width, 0); // Bottom right
    path.lineTo(size.width / 2, size.width); // Top center
    path.close();

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: GoogleFonts.pixelifySans(
          color: white,
          fontWeight: FontWeight.normal,
          fontSize: 28
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    canvas.drawPath(path, paint);
    textPainter.layout(maxWidth: size.width-padding);
    final offset = Offset(
      (size.width - textPainter.width) / 2, // Center horizontally
      (size.width - textPainter.height) / 3, // Center vertically
    );
    textPainter.paint(canvas, offset);
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate is TrianglePainter && oldDelegate.text != text;
  }
}
