import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animated spinner with rotating effect
            RotationTransition(
              turns: AlwaysStoppedAnimation(90 / 360),
              child: Container(
                width: 70.0,
                height: 70.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  strokeWidth: 6.0,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Fun loading text
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
