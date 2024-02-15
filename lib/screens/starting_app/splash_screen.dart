import 'package:blood_donation/screens/starting_app/login.dart';
import 'package:blood_donation/screens/starting_app/on_boarding.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome(); // Navigate to Home Screen after a delay
  }

  // Simulate a delay using Future.delayed
  void _navigateToHome() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => OnBoardingScreen(),
        ),
      );
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
        child: Image.asset('assets/images/logo-with-name.png'), // Display your logo
      ),
    );
  }
}