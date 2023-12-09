import 'package:animate_do/animate_do.dart';
import 'package:expense_tracker/screens/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to simulate a delay
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to your main screen (Expenses)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Expenses()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 800),
              child: Image.asset('assets/images/logo.png'),
            ), // Replace with your image asset
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: const Text(
                'Expense Tracker',
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Splash',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
