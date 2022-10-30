import 'package:flutter/material.dart';

import '../Utilities/TaskUI.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final  User? user = Auth().currentUser;
  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 130, 194, 247),
      appBar: AppBar(
        title: const Text('Daily Task'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => const TaskUI(),
        itemCount: 10,),
      );
  }
}
