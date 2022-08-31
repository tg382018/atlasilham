import 'package:atlasilham/firebase_process/firestore.dart';
import 'package:atlasilham/screens/adminpages/admin_main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginmain extends StatefulWidget {
  const Loginmain({Key? key}) : super(key: key);

  @override
  State<Loginmain> createState() => _LoginmainState();
}

class _LoginmainState extends State<Loginmain> {
  var frtool=Firestore();
  var tfKullaniciAdi = TextEditingController();
  var tfSifre = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> girisKontrol() async {
    var ka = tfKullaniciAdi.text;
    var s = tfSifre.text;

    if(ka == "admin" && s == "123"){
      var sp = await SharedPreferences.getInstance();

      sp.setString("kullaniciAdi", ka);
      sp.setString("sifre", s);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => mainPage(katlist: frtool.readCategory(), itemlist: frtool.readItem())));
    }else{
      scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text("Giriş Hatalı"),));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Login Ekranı"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/y.png",height: 111,width: 111,),
              TextField(controller: tfKullaniciAdi,decoration: InputDecoration(hintText: "Kullanıcı adı giriniz"),),
              TextField(controller: tfSifre,decoration: InputDecoration(hintText: "Sifre giriniz",),obscureText: true,),
              RaisedButton(
                child: Text("Giriş Yap"),
                onPressed: (){
                  girisKontrol();
                },
              ),
            ],
          ),
        ),
      ),

    );
  }
}
