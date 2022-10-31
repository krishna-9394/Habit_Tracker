// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:habit_tracker/Authentications_Pages/register.dart';
// import 'package:provider/provider.dart';
//
// import '../Utilities/ButtonWidgets.dart';
// import '../Utilities/Home_Model.dart';
// import '../Utilities/TextField.dart';
// import '../Utilities/Toast.dart';
// import '../Utilities/Waves.dart';
//
// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);
//
//   @override
//   State<Register> createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   String password = "";
//   String email = "";
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//
//   void _register() async {
//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } catch (e) {
//       print("error: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final model = Provider.of<HomeModel>(context);
//     final bool isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
//     return Scaffold(
//         appBar: AppBar(title: const Text("Home")),
//         backgroundColor: Global.white,
//         body: Stack(
//           children: [
//             Container(
//               height: size.height - 200,
//               color: Global.mediumBlue,
//             ),
//             AnimatedPositioned(
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeOutQuad,
//               top: isKeyBoardOpen ? - (size.height)/3.7 : 0.0,
//               child: WaveWidget(
//                 size: size,
//                 yOffset: size.height/3.0,
//                 color: Global.white,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.only(top: 100),
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       color: Global.white,
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(30),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextFieldWidget(
//                     hintText: 'Email',
//                     obscureText: false,
//                     prefixIconData: Icons.mail_outline,
//                     suffixData: model.isValid ? Icons.check : null,
//                     onChanged: (value) {
//                       model.isValidEmail(value);
//                       email = value;
//                     },
//                   ),
//                   const SizedBox(height: 10.0),
//                   TextFieldWidget(
//                     hintText: 'Password',
//                     obscureText: model.isVisible? false : true,
//                     prefixIconData: Icons.lock_outline,
//                     suffixData: model.isVisible? Icons.visibility :
//                     Icons.visibility_off,
//                     onChanged: (value){
//                       password = value;
//                     },
//                   ),
//                   const SizedBox(height: 20.0),
//                   const SizedBox(height: 20.0),
//                   ButtonWidget(
//                     hasBorder: false,
//                     title: 'Login',
//                     onPressed: () {
//                       _register();
//                     },
//                   ),
//                   const SizedBox(height: 10.0),
//                   ButtonWidget(
//                     hasBorder: true,
//                     title: 'SignUp',
//                     onPressed: () {}
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         )
//     );
//   }
// }
//
