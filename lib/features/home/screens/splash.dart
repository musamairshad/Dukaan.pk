import 'dart:async';
import 'package:bloc_learning/features/home/screens/home.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/icon.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 35),
          Text(
            'Dukaan.pk',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.green.shade900,
            ),
          ),
        ],
      ),
    );
  }
}
