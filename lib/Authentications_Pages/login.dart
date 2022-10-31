import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Utilities/ButtonWidgets.dart';
import '../Utilities/Home_Model.dart';
import '../Utilities/TextField.dart';
import '../Utilities/Waves.dart';

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
    final size = MediaQuery.of(context).size;
    final model = Provider.of<HomeModel>(context);
    final bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        backgroundColor: Global.white,
        body: Stack(
          children: [
          Container(
            height: size.height - 200,
            color: Global.mediumBlue,
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: isKeyBoardOpen ? - (size.height)/3.7 : 0.0,
            child: WaveWidget(
              size: size,
              yOffset: size.height/3.0,
              color: Global.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Global.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30),
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text(
                        "forgot password?",
                        style: TextStyle(
                          color: Global.mediumBlue,
                        )
                    )
                  ]
              ),
              const SizedBox(height: 20.0),
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
          ),
          ],
        )
    );
  }
}

