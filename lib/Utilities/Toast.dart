import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class Toast {
  createToast(String message){
    Fluttertoast.showToast(  
        msg: message,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIosWeb: 1,  
        backgroundColor: Color.fromARGB(255, 255, 255, 255),  
        textColor: Color.fromARGB(255, 0, 0, 0)  
    );  

  }
}