import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class HomeModel extends ChangeNotifier{
  bool _isVisble = false;
  get isVisible => _isVisble;
  set isVisible(value){
    _isVisble = value;
    notifyListeners();
  }

  get isValid => _isValid ;
  bool _isValid = false;
  void isValidEmail(String value){
    if(value == "") {
      _isValid = false;
    } else if(EmailValidator.validate(value)) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }



}



