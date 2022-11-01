import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Utilities/Toast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../Authentications_Pages/Auth.dart';
import '../Utilities/Boxes.dart';
import '../Utilities/TaskUI.dart';
import '../Utilities/habit.dart';
import 'newHabit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Habit> habitsList = [];
  final  User? user = Auth().currentUser;
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final box = Boxes.getTransaction();
    habitsList = box.values.toList();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    // Hive.box('box_name').close()
    super.dispose();

  }
  void addHabit(String habitName,String time){
    setState(() {
      int  hours = double.parse(time.substring(0,2)).toInt();
      int minutes = double.parse(time.substring(3,5)).toInt();
      int secondes = double.parse(time.substring(6,8)).toInt();
      int totalTime = hours*3600 + minutes*60 +secondes;
      final habit = Habit();
      habit.habitName = habitName;
      habit.timeSpent = 0;
      habit.goalTime = totalTime;
      final box = Boxes.getTransaction();
      box.put(habit.habitName,habit);
    });
  }
  void onHabitStarted(int index){
    // noting the start time
    var startTime = DateTime.now();
    // setting the changing the state of hasStarted
    setState(() {
      habitsList[index].hasStarted = !(habitsList[index].hasStarted);
    });
    if(habitsList[index].hasStarted) {
      int prevTime = (habitsList[index].timeSpent as int);
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if(!(habitsList[index].hasStarted)) timer.cancel();
          var currentTime = DateTime.now();
           var timeElapsed = (currentTime.hour-startTime.hour)*3600 + (currentTime.minute-startTime.minute)*60 +currentTime.second-startTime.second;
           if(timeElapsed>=(habitsList[index].hasStarted as int)){
             timer.cancel();

           }
          habitsList[index].goalTime = timeElapsed+prevTime;
        });
      });
      setState(() {

      });
    }
    // timer

  }
  void onDelete(int index){
    Toast().createToast("message");
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text("settings for ${habitsList[index].habitName}"),
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
        actions: [
          const SizedBox(width: 10,),
          IconButton(
              onPressed: signOut,
              icon: const Icon(Icons.power_settings_new,size: 30)),
          const SizedBox(width: 20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: habitsList.isEmpty ? ListView.builder(
          itemBuilder: (context, index) => TaskUI(
            habitName: habitsList[index].habitName,
            timeSpent: habitsList[index].timeSpent,
            timeGoal: habitsList[index].goalTime,
            habitStarted: habitsList[index].hasStarted,
            onTap: (){
              onHabitStarted(index);
            },
            settingTap: () {
              onDelete(index);
            },
          ),
          itemCount: habitsList.length,) :
        const Center(
          child: Text(
            'No expenses yet!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,),
        onPressed: (){
          showModalBottomSheet(context: context, builder: ((builderContext){
            return NewHabit(addHabit);
          }));
        },
      )
      );
  }
}


