import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Home Pages/home_page.dart';
import '../Utilities/Toast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController emailEditor = TextEditingController();
  final TextEditingController passwordEditor = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _Register() async {
    if (emailEditor.text.isEmpty || emailEditor.text == '') return;
    if (!EmailValidator.validate(emailEditor.text)) return;
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: emailEditor.text, password: passwordEditor.text);
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Registration")),
      body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/signup.png', height: 200, width: 200),
              const SizedBox(height: 10, width: double.infinity),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: emailEditor,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Email'),
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10, width: double.infinity),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: TextField(
                  controller: passwordEditor,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: 'Password'),
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 10, width: double.infinity),
              ElevatedButton(
                onPressed: () {
                  _Register();
                  Toast().createToast("Login Successfully...");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Home()),
                  );
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      backgroundColor: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Toast().createToast("Login...");
                        Navigator.pop(context,);
                      },
                      child: const Text("already have account? click here")),
                ],
              )
            ],
          )),
    );
  }
}
