import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/Utilities/Authentification/Home_Model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'Authentications_Pages/login.dart';
import 'Home Pages/home_page.dart';
import 'Utilities/Authentification/TextField.dart';
import 'Utilities/habit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initializing the Firebase
  await Firebase.initializeApp();
  // initializing the Hive
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('Habits List');
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
        home: ChangeNotifierProvider(
            create: (_) => HomeModel(),
            child: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
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
