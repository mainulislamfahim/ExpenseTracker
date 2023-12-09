import 'package:animate_do/animate_do.dart';
import 'package:expense_tracker/screens/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use Future.delayed to simulate a delay
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to your main screen (Expenses)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Expenses()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              child: Image.asset('assets/images/logo.png'),
              duration: Duration(milliseconds: 800),
            ), // Replace with your image asset
            SizedBox(height: 16),
            FadeInUp(
              child: Text(
                'Expense Tracker',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              duration: Duration(milliseconds: 800),
            ),
          ],
        ),
      ),
    );
  }
}
