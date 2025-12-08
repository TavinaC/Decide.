import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          border: Border.all(color: primaryLight, width: border),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: NumberGenerator(),
      ),
    );
  }
}

class NumberGenerator extends StatefulWidget {
  const NumberGenerator({super.key});

  @override
  State<NumberGenerator> createState() => _NumberGenerator();
}

class _NumberGenerator extends State<NumberGenerator> {
  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  static String rand = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState(); // Always call super.initState() first
    rand = "";
  }

  @override
  void dispose() {
    _num1.dispose();
    _num2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: const BoxConstraints.expand(),
      padding: EdgeInsets.all(2*padding),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Center(child: Text("Enter a Range:")),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: 2 * padding,
                    right: 2 * padding,
                    top: 2 * padding,
                  ),
                  child: Input(num1: _num1, num2: _num2, text: "Min:"),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.only(
                    left: 2 * padding,
                    right: 2 * padding,
                    top: 2 * padding,
                  ),
                  child: Input(num1: _num2, num2: _num1, text: "Max:"),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsetsGeometry.all(2 * padding),
                child: FittedBox(fit: BoxFit.contain, child: Text(rand)),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     if (formKey.currentState!.validate()) {
            //       int num1 = int.parse(_num1.text);
            //       int num2 = int.parse(_num2.text);

            //       setState(() {
            //         rand = NumberFormat.decimalPattern().format(
            //           Random().nextInt(num2 - num1 + 1) + num1,
            //         );
            //       });
            //     }
            //   },
            //   child: Container(
            //     height: 6 * padding,
            //     margin: EdgeInsets.all(padding),
            //     decoration: BoxDecoration(
            //       color: primary,
            //       border: Border.all(color: primaryLight, width: border),
            //       borderRadius: BorderRadius.circular(radius),
            //     ),
            //     child: Center(
            //       child: Text(
            //         "Generate",
            //         style: TextStyle(color: white, fontSize: 32),
            //       ),
            //     ),
            //   ),
            // ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(height: 6*padding),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    int num1 = int.parse(_num1.text);
                    int num2 = int.parse(_num2.text);
              
                    setState(() {
                      rand = NumberFormat.decimalPattern().format(
                        Random().nextInt(num2 - num1 + 1) + num1,
                      );
                    });
                  }
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
                child: Text("Generate", style: GoogleFonts.dynaPuff(color: white, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 2))),
            )
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    super.key,
    required this.num1,
    required this.num2,
    required this.text,
  });

  final TextEditingController num1;
  final TextEditingController num2;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: padding,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: 22),
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          flex: 4,
          child: TextFormField(
            controller: num1,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
              LengthLimitingTextInputFormatter(9),
            ],
            style: Theme.of(context).textTheme.bodyMedium,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty.';
              }
              int? n1 = (text == "Min:")
                  ? int.parse(num1.text)
                  : int.tryParse(num2.text);
              int? n2 = (text == "Max:")
                  ? int.parse(num1.text)
                  : int.tryParse(num2.text);

              if (n1 != null && n2 != null && n1 + 1 > n2) {
                return (text == "Min:")
                    ? 'Min must be < Max'
                    : 'Max must be > Min';
              }

              return null;
            },
            decoration: InputDecoration(
              helperText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: yellow, width: border),
                borderRadius: BorderRadius.circular(radius / 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: yellow, width: border),
                borderRadius: BorderRadius.circular(radius / 2),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: border),
                borderRadius: BorderRadius.circular(radius / 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primary, width: border),
                borderRadius: BorderRadius.circular(radius / 2),
              ),
              fillColor: yellowLight,
              filled: true,
              hoverColor: yellowLight,
            ),
          ),
        ),
      ],
    );
  }
}
