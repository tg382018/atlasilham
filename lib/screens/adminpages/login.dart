import 'package:atlasilham/firebase_process/firestore.dart';
import 'package:atlasilham/screens/adminpages/admin_main.dart';
import 'package:atlasilham/screens/adminpages/login_main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<bool> oturumKontrol() async {
    var sp = await SharedPreferences.getInstance();

    String spKullaniciAdi = sp.getString("kullaniciAdi") ?? "kullanıcı adı yok";
    String spSifre = sp.getString("sifre") ?? "şifre yok";

    if(spKullaniciAdi == "admin" && spSifre == "123"){
      return true;
    }else{
      return false;
    }}


  @override
  Widget build(BuildContext context) {
    var frtool=Firestore();
    return Scaffold(


      body: FutureBuilder<bool>(
        future: oturumKontrol(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            bool? gecisIzni = snapshot.data;
            if(gecisIzni==true)
              {

                return mainPage(katlist: frtool.readCategory(), itemlist: frtool.readItem());
              }
            else
              {
                return Loginmain();
              }

          }

          else{
            return Container();
          }
        },
      ),
    );
  }
}
