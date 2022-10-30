import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utilities/ButtonWidgets.dart';
import '../Utilities/Home_Model.dart';
import '../Utilities/TextField.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailEditor = TextEditingController();
  final TextEditingController passwordEditor = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void _Login() async {
    if (emailEditor.text.isEmpty || emailEditor.text == '') return;
    if (!EmailValidator.validate(emailEditor.text)) return;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailEditor.text, password: passwordEditor.text);
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<HomeModel>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        backgroundColor: Global.white,
        body: Center(
            child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextFieldWidget(
                        hintText: 'Email',
                        obscureText: false,
                        prefixIconData: Icons.mail_outline,
                        suffixData: model.isValid ? Icons.check : null,
                        onChanged: (value) {
                          model.isValidEmail(value);
                        },
                      ),
                      const SizedBox(height: 10.0),
                      TextFieldWidget(
                        hintText: 'Password',
                        obscureText: model.isVisible? false : true,
                        prefixIconData: Icons.lock_outline,
                        suffixData: model.isVisible? Icons.visibility :
                        Icons.visibility_off,
                      ),
                      const SizedBox(height: 20.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                                "forgot password?",
                                style: TextStyle(
                                  color: Global.mediumBlue,
                                )
                            )
                          ]
                      ),
                      ButtonWidget(
                        hasBorder: false,
                        title: 'Login',
                        onPressed: () {

                        },
                      ),
                      const SizedBox(height: 10.0),
                      ButtonWidget(
                        hasBorder: true,
                        title: 'SignUp',
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}

