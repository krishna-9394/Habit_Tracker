import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Utilities/Toast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../Authentications_Pages/Auth.dart';
import '../Utilities/Boxes.dart';
import '../Utilities/HabitUI.dart';
import '../Utilities/habit.dart';
import 'newHabit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Habit> habitsList = [];
  final  User? user = Auth().currentUser;
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final box = Boxes.getTransaction();
    List<Habit> lists = box.values.toList();
    for(int i = 0;i<lists.length;i++){
      Habit temp = lists.elementAt(i);
      print("${temp.habitName} ${temp.hasStarted} ${temp.timeSpent} ${temp.goalTime}");
      habitsList.add(temp);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    // Hive.box('box_name').close()
    super.dispose();

  }
  Future addHabit(String habitName,int time) async {
    final habit = Habit()
    ..habitName = habitName
    ..timeSpent = 0
    ..goalTime = time
    ..hasStarted = false;

    final box = Boxes.getTransaction();
    box.add(habit);
    Toast().createToast("added...");
  }
  void onHabitStarted(Habit habit){
    // noting the start time
    var startTime = DateTime.now();
    // setting the changing the state of hasStarted
    setState(() {
      habit.hasStarted = !(habit.hasStarted);
    });
    if(habit.hasStarted) {
      int prevTime = habit.timeSpent;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if(!(habit.hasStarted)) timer.cancel();
          var currentTime = DateTime.now();
           var timeElapsed = (currentTime.hour-startTime.hour)*3600 + (currentTime.minute-startTime.minute)*60 +currentTime.second-startTime.second;
           if(timeElapsed>=(habit.hasStarted as int)){
             timer.cancel();

           }
          habit.goalTime = timeElapsed+prevTime;
        });
      });
      setState(() {

      });
    }
    // timer

  }
  void onDelete(Habit habit){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Delete"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(onPressed:(){ habit.delete(); Navigator.of(context).pop(); Toast().createToast("deleted..."); } ,style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)), child: const Text("ok",style: TextStyle(color: Colors.green),),),
          TextButton(onPressed:(){ Navigator.of(context).pop(); } ,style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)), child: const Text("cancel",style: TextStyle(color: Colors.red),),),
        ],
      );
    });
  }
  void onSave(Habit habit){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Update"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(onPressed:(){ habit.save(); Navigator.of(context).pop(); Toast().createToast("deleted..."); } ,style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)), child: const Text("ok",style: TextStyle(color: Colors.black),),),
          TextButton(onPressed:(){ Navigator.of(context).pop(); } ,style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)), child: const Text("cancel",style: TextStyle(color: Colors.black),),),
        ],
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
              onPressed: (){
                signOut();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.power_settings_new,size: 30)),
          const SizedBox(width: 20,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20,bottom: 20),
        child: ValueListenableBuilder<Box<Habit>>(
          valueListenable: Boxes.getTransaction().listenable(),
          builder: (context, box, _) {
            final habits = box.values.toList().cast<Habit>();
            return buildContent(habits);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add,),
        onPressed: (){
          showDialog(context: context, builder: ((builderContext){
            return NewHabit(addHabit);
          }));
        },
      )
      );
  }
  Widget buildContent(List<Habit> habits){
    if(habits.isEmpty) {
      return const Center(
      child: Text(
        'No expenses yet!',
        style: TextStyle(fontSize: 24),
      ),
    );
    }
    else {
      return ListView.builder(
      itemBuilder: (context, index) => HabitUI(
        habit: habits[index],
        onTap: (){
          onHabitStarted(habits[index]);
        },
        settingTap: () {
          onDelete(habits[index]);
        },
      ),
      itemCount: habits.length,);
    }
  }
}