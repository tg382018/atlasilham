

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/categories.dart';
import '../classes/Items.dart';

class Firestore

{
  List<String> ?droplist;

  Future<void> addCategory(int kategori_sirasi,
      String kategori_ad,
      String kategori_resim,) async
  {
    final docUser=FirebaseFirestore.instance.collection('kategoriler').doc();
    var bilgi=HashMap<String,dynamic>();
    bilgi["id"]=docUser.id;
    bilgi["kategori_sirasi"]=kategori_sirasi;
    bilgi["kategori_ad"]=kategori_ad;
    bilgi["kategori_resim"]=kategori_resim;

    await docUser.set(bilgi);
  }

  Future<void> addItem(String item_baslik,
  String item_uzunmetin,
  String item_konu,
  String item_link,
  String item_tarih,
  String item_resim,
  String item_hafta,
  String kategori_ad,
  bool one_cikarilan) async
  {
    final docUser=FirebaseFirestore.instance.collection('items').doc();
    var bilgi=HashMap<String,dynamic>();
    bilgi["id"]=docUser.id;
    bilgi["item_baslik"]=item_baslik;
    bilgi["item_uzunmetin"]=item_uzunmetin;
    bilgi["item_konu"]=item_konu;
    bilgi["item_link"]=item_link;
  bilgi["item_tarih"]=item_tarih;
  bilgi["item_resim"]=item_resim;
  bilgi["item_hafta"]=item_hafta;
  bilgi["kategori_ad"]=kategori_ad;
  bilgi["one_cikarilan"]=one_cikarilan;

    await docUser.set(bilgi);
  }


  Future <List<Kategoriler>>readCategory() async
  {

    final querysnapshot=await FirebaseFirestore.instance.collection("kategoriler").get();
    List<QueryDocumentSnapshot> docs=querysnapshot.docs;
    final list=docs.map((doc) => Kategoriler.fromJson(doc.data() as dynamic)).toList();


    //Sorting
    for(int j=0;j<list.length-1;j++)
    {
      for(int i=0;i<list.length-1;i++)
      {
        if(list[i].kategori_sirasi>list[i+1].kategori_sirasi)
        {
          Kategoriler gecici=list[i];
          list[i]=list[i+1];
          list[i+1]=gecici;
        }
      }}

    for(int j=0;j<list.length-1;j++)
    {
      droplist?.add(list[j].kategori_ad);
      }

    return list;
  }

  Future <List<Items>>readItem() async
  {
    final querysnapshot=await FirebaseFirestore.instance.collection("items").get();
    List<QueryDocumentSnapshot> docs=querysnapshot.docs;
    final list=docs.map((doc) => Items.fromJson(doc.data() as dynamic)).toList();
    return list;
  }

  Future delCategory(String key) async
  {
    var collection = FirebaseFirestore.instance.collection("kategoriler");
    await collection.doc(key).delete();
  }

  Future delItem(String key) async
  {
    var collection = FirebaseFirestore.instance.collection("items");
    await collection.doc(key).delete();
  }


}