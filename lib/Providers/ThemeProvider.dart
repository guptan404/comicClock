import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/constants.dart';

class ThemeProvider extends ChangeNotifier {

  TextStyle selectedFont = GoogleFonts.robotoFlex(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: kPrimaryColor
    //color: Colors.black, // Adjust text color as needed
  );

  String cf = "Roboto Flex";
  String theme = "cartoon";
  bool firstOpen = true;

  Future<void> getFontFromSharedPrefrences()
  async {
    // add firstOpen to sharedPrefrences
    SharedPreferences sharedPreferences =  await SharedPreferences.getInstance();
    String? fontName = sharedPreferences.getString("font");
    String? themeName = sharedPreferences.getString("theme");
    bool? firstOpen = sharedPreferences.getBool("firstOpen");
    if(firstOpen != null)
      {
        this.firstOpen = firstOpen;
      }
    if(themeName !=null)
      {
        theme = themeName;
      }
    if(fontName !=null)
      {
        cf = fontName;
        selectedFont = AppConstants.fonts[cf]!;
      }

  }

  void changeTheme(String themeName) {
    theme = themeName;
    SharedPreferences.getInstance().then((value) => value.setString("theme", theme));
    notifyListeners();
  }


  void changeFont(TextStyle font, String fontName) {
    selectedFont = font;
    String cf = fontName;
    SharedPreferences.getInstance().then((value) => value.setString("font", cf));
    notifyListeners();
  }
}