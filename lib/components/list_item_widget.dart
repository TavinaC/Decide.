import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    super.key,
    required this.item,
    required this.animation,
    required this.onClicked,
  });

  final String item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.all(padding / 2),
    title: Text(
      item,
      style: GoogleFonts.dynaPuff(
        fontSize: 20,
        color: primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    ),
    leading: GestureDetector(
      onTap: onClicked,
      child: Text(
        "X",
        style: GoogleFonts.dynaPuff(
          fontSize: 28,
          color: primary,
          // fontWeight: FontWeight.bold,
          letterSpacing: 2,
        ),
      ),
    ),
  );
}
