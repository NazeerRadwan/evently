import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager{
  static late SharedPreferences sharedPreferences;
  static int()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static setTheme(ThemeMode mode){
    String themeValue = "light";
    if (mode == ThemeMode.dark) {
      themeValue = "dark";
    } else if (mode == ThemeMode.system) {
      themeValue = "system";
    }
    sharedPreferences.setString("theme", themeValue);
  }
  static ThemeMode getTheme(){
    String saved = sharedPreferences.getString("theme")??"light";
    if(saved == "dark"){
      return ThemeMode.dark;
    } else if (saved == "system") {
      return ThemeMode.system;
    } else {
      return ThemeMode.light;
    }
  }
}