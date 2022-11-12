import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xff777be7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Image.asset(
              "assets/images/login.png",
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Supported By  ",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Image.asset(
                  "assets/images/fire.png",
                  scale: 10,
                ),
              ],
            ),
            const Spacer(),
            const LinearProgressIndicator(
              color: Colors.purple,
              backgroundColor: Color(0xff777be7),
              minHeight: 12,
            ),
          ],
        ),
      ),
    );
  }
}
