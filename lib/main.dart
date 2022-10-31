import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Utilities/Home_Model.dart';
import 'package:provider/provider.dart';
import 'Authentications_Pages/Auth.dart';
import 'Authentications_Pages/login.dart';
import 'Home Pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Habit Tracker',
        theme: ThemeData(primarySwatch: Colors.blue),
        home:
        ChangeNotifierProvider(
          create: (_) => HomeModel(),
          child:
          // Login(),
    StreamBuilder(
      stream: Auth().authStateChange,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData) {
          return const Home();
        } else {
          return const Login();
        }
      },),
        )
    );
  }
}
