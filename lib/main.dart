import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:atlasilham/firebase_process/firestore.dart';

import 'package:atlasilham/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyA-yFDzZwbrjUxxGNPQEkysfQLtrGQQ3QQ",
          appId: "1:596310292109:android:add927630d831bc6f354c4",
          messagingSenderId: "596310292109",
          projectId: "atlas-d24f7",
          databaseURL: "https://atlas-d24f7-default-rtdb.firebaseio.com",
          storageBucket: "atlas-d24f7.appspot.com"),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool darkTheme = false;

  void switcher() {
    setState(() {
      darkTheme = !darkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İlham Atlası',
      theme: !darkTheme ? MyTheme().myThemeLight : ThemeData.dark(),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var frtool = Firestore();

  Future<void> cikisYap() async {
    var sp = await SharedPreferences.getInstance();

    sp.remove("kullaniciAdi");
    sp.remove("sifre");
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: 'assets/images/y.png',
      screenFunction: () async {
        return MainScreen(
            categoryList: frtool.readCategory(), itemlist: frtool.readItem());
      },
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 125,
    );
  }
}
