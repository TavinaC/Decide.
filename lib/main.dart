import 'package:decide2/components/audio_controller.dart';
import 'package:decide2/pages/coin_flip.dart';
import 'package:decide2/pages/magic_ball.dart';
import 'package:decide2/pages/rng.dart';
import 'package:decide2/pages/spin_wheel.dart';
import 'package:decide2/styles/colors.dart';
import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final audioController = AudioController();
  await audioController.initialize();
  
  runApp(MainApp(audioController: audioController));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.audioController, super.key});

  final AudioController audioController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        textTheme: TextTheme(
          titleLarge: GoogleFonts.dynaPuff(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: white,
            letterSpacing: 2,
          ),
          titleMedium: GoogleFonts.dynaPuff(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: white,
            letterSpacing: 2,
          ),
          bodyMedium: GoogleFonts.dynaPuff(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryDark,
            letterSpacing: 2,
          ),
          // Define other text styles as needed
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/rng': (context) => const RNG(),
        '/coin': (context) => const Coin(),
        //'/dice': (context) => const Dice(),
        '/wheel': (context) => Wheel(audioController: audioController),
        '/magic_ball': (context) => const MagicBall(),
      },
    );
  }
}
