// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_single_quotes, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';

class ChristmasCountdownApp extends StatefulWidget {
  @override
  _ChristmasCountdownAppState createState() => _ChristmasCountdownAppState();
}

class _ChristmasCountdownAppState extends State<ChristmasCountdownApp> {
  late Timer countdownTimer;
  late DateTime today = DateTime.now();
  late DateTime christmas = DateTime(today.year, 12, 25);
  late Duration remainingTime = Duration.zero;

  String get countdownText {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(remainingTime.inDays);
    final hours = strDigits(remainingTime.inHours.remainder(24));
    final minutes = strDigits(remainingTime.inMinutes.remainder(60));
    final seconds = strDigits(remainingTime.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds"; // Only show hours, minutes, and seconds
  }

  String get daysText {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(remainingTime.inDays);
    return "$days Days";
  }

  void setCountdown() {
    setState(() {
      remainingTime = christmas.difference(DateTime.now());
    });

    if (remainingTime.isNegative) {
      countdownTimer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    countdownTimer = Timer.periodic(Duration(seconds: 1), (_) => setCountdown());
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          elevation: 0,
          title: Text("Christmas Countdown"),
          backgroundColor: Colors.redAccent,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.exit_to_app_sharp),
            )
          ],
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                daysText, // Show days above hours, minutes, and seconds
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 80,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                countdownText,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  fontSize: 60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


