import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Utilities/Toast.dart';

import '../Authentications_Pages/Auth.dart';
import '../Utilities/TaskUI.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   var habitsList = [
    ["Exercise",false,0,10,],
    ["Read",false,0,20],
    ["Meditate",false,0,15],
    ["Code",false,0,45]
  ];
  final  User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }


  void onHabitStarted(int index){
    // noting the start time
    var startTime = DateTime.now();
    // setting the changing the state of hasStarted
    setState(() {
      habitsList[index][1] = !(habitsList[index][1] as bool);
    });
    if(habitsList[index][1] as bool) {
      var prevTime = (habitsList[index][2] as int);
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if(!(habitsList[index][1] as bool)) timer.cancel();
          var currentTime = DateTime.now();
           var timeElapsed = (currentTime.hour-startTime.hour)*3600 + (currentTime.minute-startTime.minute)*60 +currentTime.second-startTime.second;
           if(timeElapsed>=(habitsList[index][3] as int)){
             timer.cancel();
           }
          habitsList[index][2] = timeElapsed+prevTime;
        });
      });
      setState(() {

      });
    }
    // timer

  }
  void onSettingOpened(int index){
    Toast().createToast("message");
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("settings for ${habitsList[index][0]}"),

      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Daily Task'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: ListView.builder(
          itemBuilder: (context, index) => TaskUI(
            habitName: habitsList[index][0] as String,
            timeSpent: habitsList[index][2] as int,
            timeGoal: habitsList[index][3] as int,
            habitStarted: habitsList[index][1] as bool,
            onTap: (){
              onHabitStarted(index);
            },
            settingTap: () {
              onSettingOpened(index);
            },
          ),
          itemCount: habitsList.length,),
      ),
      );
  }
}
