import 'package:flutter/material.dart';

class MyTheme {
  ThemeData myThemeLight = ThemeData.light().copyWith(
    iconTheme: IconThemeData(
      color: Colors.atlasmavisi,
    ),
    listTileTheme: ListTileThemeData(

      iconColor: Colors.atlasmavisi,

    ),



    cardTheme: CardTheme(),
    appBarTheme: AppBarTheme(
      color: Colors.atlasmavisi,
      titleTextStyle: TextStyle(
        color: Colors.black,
      ),
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),

    tabBarTheme: const TabBarTheme().copyWith(

      labelColor: Colors.atlasmavisi,
      unselectedLabelColor: Colors.black,
      overlayColor: MaterialStateProperty.all(Colors.black),
      labelPadding: const EdgeInsets.all(5),

    ),
  );



}
