// ignore_for_file: prefer_const_constructors, prefer_single_quotes, prefer_const_constructors_in_immutables, prefer_const_declarations
import 'dart:async';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class christmasTimer extends StatelessWidget {
  
  Timer? countdownTimer;
  late DateTime today = DateTime.now();
  late  DateTime christmas = DateTime(today.year, 12, 25);
  late Duration remainingDays = christmas.difference(today);
        
    void startTimer(){
    countdownTimer = Timer.periodic(Duration (seconds: 1), (_) => setCountDown());
    } 

    void stopTimer(){
       countdownTimer!.cancel();
    }

    void resetTimer(){
      stopTimer();
      remainingDays = christmas.difference(today);
    }

    void setCountDown(){
      final reduceSecondsBy = 1;
      final seconds = remainingDays.inSeconds - reduceSecondsBy;
        if(seconds < 0){
          countdownTimer!.cancel();
        }
        else{
          remainingDays = Duration(seconds: seconds);
        } 
    }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final days = strDigits(remainingDays.inDays);
    final hours = strDigits(remainingDays.inHours.remainder(24));
    final minutes = strDigits(remainingDays.inMinutes.remainder(60));
    final seconds = strDigits(remainingDays.inSeconds.remainder(60));
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Christmas Countdown"),
          backgroundColor: Colors.redAccent,
          leading: IconButton(onPressed: () {
            
          }, icon: Icon(Icons.menu)),
          actions: [IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app_sharp))],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),

              Text(
                "$hours: $minutes:$seconds",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),

              SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: startTimer, 
                child: Text(
                  "Start",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                ),

              ElevatedButton(
                onPressed: (){
                  if(countdownTimer == null || countdownTimer!.isActive){
                    stopTimer();
                  }
                }, 
                child: Text(
                  "Stop",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                ),

              ElevatedButton(
                onPressed: (){
                  resetTimer();
                }, 
                child: Text(
                  "Reset",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                ),
          ],
          ),
        ),
      ),
    );
  }
}