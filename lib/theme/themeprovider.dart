import 'package:cubaantest/theme/darkmode.dart';
import 'package:cubaantest/theme/lightmode.dart';
import 'package:flutter/material.dart';

class Themeprovider with ChangeNotifier{

  ThemeData _themeData = lightmode;

  ThemeData get  themedata => _themeData ;

  bool get isdarkmode => _themeData == darkmode;

  set themedata(ThemeData themedata){
    _themeData = themedata;
    notifyListeners();

  }

  void toogletheme(){
    if (_themeData == lightmode){
      _themeData = darkmode;
    }
    else{
      _themeData = lightmode;
    }
  }

}