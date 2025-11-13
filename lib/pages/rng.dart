import 'dart:math';

import 'package:decide2/components/base_page.dart';
import 'package:decide2/styles/colors.dart';
import 'package:decide2/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        child: NumberGenerator(),
    ));
  }
}

class NumberGenerator extends StatefulWidget{
  
  const NumberGenerator({super.key,});

  @override
  State<NumberGenerator> createState() => _NumberGenerator();
  
}

class _NumberGenerator extends State<NumberGenerator> {
  
  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  final String rand = "";

  @override
  Widget build(BuildContext context) {
    return Container(
          constraints: const BoxConstraints.expand(),
          padding: EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child:Text("Enter a Range:")),
              Padding(
                padding: EdgeInsetsGeometry.only(left: 2*padding, right: 2*padding, top: 2*padding),
                child: Row(
                  spacing: padding,
                  children: [
                  Expanded(
                    child: Text("Min:", textAlign: TextAlign.center,),
                  ),
                  Expanded (
                    flex: 4,
                    child: Input(num: _num1)
                   ),
                ],),
              ),
              Padding(
                padding: EdgeInsetsGeometry.all(2*padding),
                child: Row(
                  spacing: padding,
                  children: [
                  Expanded(
                    child: Text("Max:", textAlign: TextAlign.center,),
                  ),
                  Expanded (
                    flex: 4,
                    child: Input(num: _num2)
                   ),
                ],),
              ),
              Expanded(
                child: Container (
                  margin: EdgeInsets.all(padding),
                  color: black,//implement random number here
                )
              ),
              GestureDetector(
                onTap: () {

                },
                child: Container(
                  height: 6*padding,
                  margin: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                      color: primary,
                      border: Border.all(
                        color: primaryLight,
                        width: border,
                      ),
                      borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Center( 
                    child: Text("Generate", style: TextStyle(color: white, fontSize: 32),),
                  )
                )
              )
            ],
          )
      );
  }
}

class Input extends StatelessWidget {
  const Input({super.key, required this.num});

  final TextEditingController num;

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: num,
            keyboardType: TextInputType.numberWithOptions(signed: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(
                RegExp(r'^-?\d*')
              ),
              LengthLimitingTextInputFormatter(18)
            ],
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: yellow,
                  width: border,
                ),
                borderRadius: BorderRadius.circular(radius/2)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: yellow,
                  width: border,
                ),
                borderRadius: BorderRadius.circular(radius/2)
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: primary,
                  width: border,
                ),
                borderRadius: BorderRadius.circular(radius/2)
              ),
              fillColor: yellowLight,
              filled: true,
            )
    );
  }

}