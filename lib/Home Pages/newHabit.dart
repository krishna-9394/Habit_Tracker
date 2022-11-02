import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Utilities/habit.dart';

class NewHabit extends StatefulWidget {
  final Function addHabit;
  const NewHabit(this.addHabit, {super.key});

  @override
  State<NewHabit> createState() => _NewHabitState();
}

class _NewHabitState extends State<NewHabit> {
  final bool _showError = false;
  final nameEditor = TextEditingController();
  final timeEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Add Habit"),
        content: Form(
          // key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 8),
                TextFormField(
                  controller: nameEditor,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      icon: Icon(Icons.task),
                      labelText: "enter the Habit Name..",
                      errorText: _showError? "a habit with this name already exist.." : null),),
                SizedBox(height: 8),
                TextFormField(
                    controller: timeEditor,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.timer),
                        labelText: "Enter Time"),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay? pickedTime =  await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,);
                        if(pickedTime != null ) {
                          print(pickedTime.format(context)); //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm().parse(pickedTime
                              .format(context).toString());
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm:ss').format(
                              parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                          timeEditor.text = formattedTime;
                        }
                    }
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
      onPressed: () async {
      String name = nameEditor.text.trim();
      if(name == ''){ return; }
      String time = timeEditor.text.trim();
      int  hours = double.parse(time.substring(0,2)).toInt();
      int minutes = double.parse(time.substring(3,5)).toInt();
      int secondes = double.parse(time.substring(6,8)).toInt();
      int totalTime = hours*3600 + minutes*60 +secondes;
      widget.addHabit(name,totalTime);
      Navigator.of(context,rootNavigator: true).pop();
    },
    child: const Text("Add",style: TextStyle(color: Colors.green),)),
          TextButton(
            child: const Text('Cancel',style: TextStyle(color: Colors.red)),
            onPressed: () => Navigator.of(context).pop(),
          ),
    ],
    );
  }
  // Widget build(BuildContext context) {
  //   return
  //   //   AlertDialog(
  //   //   title: Text("Add new habit"),
  //   //   content: Form(
  //   //     child: SingleChildScrollView(
  //   //       child: Column(
  //   //         mainAxisSize: MainAxisSize.min,
  //   //         children: <Widget>[
  //   //           SizedBox(height: 8),
  //   //           buildName(),
  //   //           SizedBox(height: 8),
  //   //           buildAmount(),
  //   //           SizedBox(height: 8),
  //   //           buildRadioButtons(),
  //   //         ],
  //   //       ),
  //   //     ),
  //   //   ),
  //   //   actions: <Widget>[
  //   //     buildCancelButton(context),
  //   //     buildAddButton(context, isEditing: isEditing),
  //   //   ],
  //   // );
  //     SingleChildScrollView(
  //     child: Container(
  //       margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
  //       padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: (10 + MediaQuery.of(context).viewInsets.bottom)),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Text("Add Habit",style: TextStyle(fontWeight: FontWeight.bold)),
  //           const SizedBox(height: 10),
  //           SizedBox(
  //             width: double.infinity,
  //             child: Column(
  //               children:[
  //                 TextField(
  //                   controller: nameEditor,
  //                   keyboardType: TextInputType.name,
  //                   decoration: InputDecoration(
  //                       labelText: "enter the Habit Name..",
  //                       errorText: _showError? "a habit with this name already exist.." : null),),
  //                 TextField(
  //                   controller: timeEditor, //editing controller of this TextField
  //                   decoration: const InputDecoration(
  //                     icon: Icon(Icons.timer),
  //                     labelText: "Enter Time"),
  //                     readOnly: true,
  //                     onTap: () async {
  //                       TimeOfDay? pickedTime =  await showTimePicker(
  //                         initialTime: TimeOfDay.now(),
  //                         context: context,);
  //                       if(pickedTime != null ) {
  //                         print(pickedTime.format(context)); //output 10:51 PM
  //                         DateTime parsedTime = DateFormat.jm().parse(pickedTime
  //                             .format(context).toString());
  //                         print(parsedTime); //output 1970-01-01 22:53:00.000
  //                         String formattedTime = DateFormat('HH:mm:ss').format(
  //                             parsedTime);
  //                         print(formattedTime); //output 14:59:00
  //                         //DateFormat() is from intl package, you can format the time on any pattern you need.
  //                         setState(() {
  //                           timeEditor.text = formattedTime;});
  //                       }
  //                       }
  //                     ),
  //               ],
  //             ),
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               TextButton(
  //                   onPressed: (){  Navigator.pop(context); },
  //                   child: const Text("Cancel",style: TextStyle(color: Colors.red),)),
  //               TextButton(
  //                   onPressed: () async {
  //                     String name = nameEditor.text.trim();
  //                     if(name == ''){ return; }
  //                     String time = timeEditor.text.trim();
  //                     int  hours = double.parse(time.substring(0,2)).toInt();
  //                     int minutes = double.parse(time.substring(3,5)).toInt();
  //                     int secondes = double.parse(time.substring(6,8)).toInt();
  //                     int totalTime = hours*3600 + minutes*60 +secondes;
  //                     widget.addHabit(name,totalTime);
  //                     Navigator.of(context,rootNavigator: true).pop();
  //                   },
  //                   child: const Text("Add",style: TextStyle(color: Colors.green),)),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}// class



