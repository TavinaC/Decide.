import 'package:decide2/pages/coin_flip.dart';
import 'package:decide2/pages/dice_roll.dart';
import 'package:decide2/pages/rng.dart';
import 'package:decide2/pages/spin_wheel.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      routes: {
        '/home':(context) => const HomePage(),
        '/rng':(context) => const RNG(),
        '/coin':(context) => const Coin(),
        '/dice':(context) => const Dice(),
        '/wheel':(context) => const Wheel(),
      },
    );
  }
}
