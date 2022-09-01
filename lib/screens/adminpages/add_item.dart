import 'dart:convert';
import 'dart:io';
import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/classes/Items.dart';
import 'package:atlasilham/components/dropdown.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../components/editor.dart';
import '../../firebase_process/firestore.dart';
import '../main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class addItem extends StatefulWidget {
  const addItem({Key? key, required this.katlist, required this.itemlist})
      : super(key: key);
  final Future<List<Kategoriler>> katlist;
  final Future<List<Items>> itemlist;

  @override
  _addItemState createState() => _addItemState();
}

class _addItemState extends State<addItem> {
  QuillController _controller = QuillController.basic();
  var frtool=Firestore();
  var kn1 = TextEditingController();
  var kn2 = TextEditingController();
  var kn3 = TextEditingController();
  var kn4 = TextEditingController();
  var kn5 = TextEditingController();
  var kn6 = TextEditingController();
  var kn7 = TextEditingController();
  var kn8 = TextEditingController();
  bool switchim = false;
  FirebaseStorage storageRef=FirebaseStorage.instance;
  ImagePicker filePicker=ImagePicker();
  XFile? xFilem;
  String SelectedFileName="";
  String uploadedPath="";
  String selectedValue = "Cümle Atlası";
  var jsonm;
  //final document =_loadDocument();
  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Cümle Atlası"),value: "Cümle Atlası"),
      DropdownMenuItem(child: Text("Şuur Atlası"),value: "Şuur Atlası"),
      DropdownMenuItem(child: Text("Sual Atlası"),value: "Sual Atlası"),
      DropdownMenuItem(child: Text("Hayret Atlası"),value: "Hayret Atlası"),
      DropdownMenuItem(child: Text("Kelime Atlası"),value: "Kelime Atlası"),
      DropdownMenuItem(child: Text("Film Atlası"),value: "Film Atlası"),
      DropdownMenuItem(child: Text("Kitap Atlası"),value: "Kitap Atlası"),
    ];
    return menuItems;
  }



void jsn()
{
   jsonm = jsonEncode(_controller.document.toDelta().toJson());
  print(json);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            Container(
              child: Text(
                "Paylasim Ekleme",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 21),
              ),
              alignment: Alignment.topLeft,
            ),
            Container(

                child: TextField(
                  controller: kn1,
                  decoration:
                  InputDecoration(hintText: "Baslik Giriniz", filled: true),
                )),



           Container(width:511,height:311,child: Column(

             children: [
               QuillToolbar.basic(controller: _controller),
               Container(width: 411,height: 155,
                 child: Expanded(
                   child: Container(
                     child: QuillEditor.basic(
                       controller: _controller,
                       readOnly: false, // true for view only mode
                     ),
                   ),
                 ),
               ),


             ],

           ),
           ),

        SizedBox(height: 8,),
            Container(

                child: TextField(
                  controller: kn8,
                  decoration: InputDecoration(
                      hintText: "Konuyu giriniz.", filled: true),
                )),
            Container(

                child: TextField(
                  controller: kn3,
                  decoration: InputDecoration(
                      hintText: "Web/İnsta Link Giriniz", filled: true),
                )),
            Container(

                child: TextField(
   
                  controller: kn4,
                  decoration:
                  InputDecoration(hintText: "Tarih Giriniz", filled: true),
                )),

            Container(

                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: kn6,
                  decoration: InputDecoration(

                      hintText: "Paylaşımın Haftasını girin",
                      filled: true),
                )),


            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Kategori Seçiniz"),
                dropDown(selectedValue),
              ],
            ),


            Row(
              children: [
                Text("Resim Yüklemek için butona tıklayın."),
                OutlinedButton(onPressed: (){funSelectedFile();}, child: Text("Seç")),
                OutlinedButton(onPressed: (){uploadFile(xFilem!);}, child: Text("Yükle")),
              ],
            ),
            Text(kn5.text),

            Row(children: [
              Text("Öne Çıkarılanlara Eklensin mi ?"),
              Switch(
                value: switchim,
                onChanged: (context) {
                  setState(() {
                    switchim = context;
                  });
                },
              )
            ]),
            RaisedButton(

                child: Text("Paylasım Ekle"),
                onPressed: () {
                  jsn();
                  String a = kn1.text;
                  String c = jsonm;
                  String d = kn3.text;
                  String e = kn4.text;
                  String f = kn5.text;
                  String z = kn6.text;
                  String j = kn7.text;
                  bool g = switchim;
                 frtool.addItem(a, c, kn8.text,d, e, f, z, selectedValue, g);
                  (context as Element).reassemble();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                          content: Text("Paylaşım Eklendi,paylaşımın görünmesi için lütfen uygulamayı komple kapatıp tekrar açın")));
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      MainScreen(categoryList: widget.katlist, itemlist: widget.itemlist)), (Route<dynamic> route) => false);

                }),
          ],
        ),
      ),
    );
  }


  Future<void> uploadFile(XFile xFile) async
  {

    String uploadFilename='${DateTime.now().millisecondsSinceEpoch}.png';
    Reference reference=storageRef.ref().child("Resimler").child(uploadFilename);
    UploadTask uploadTask=reference.putFile(File(xFile.path));
    uploadTask.snapshotEvents.listen((event) { });


    await uploadTask.whenComplete(() async {
      uploadedPath=await uploadTask.snapshot.ref.getDownloadURL();
      setState(() {
        kn5.text=uploadedPath;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(
          content: Text("Dosya yüklendi.")));
    });
  }
  Future<void> funSelectedFile() async
  {
    final img=await filePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      xFilem=img;
      SelectedFileName=img!.name.toString();

    });

  }

  Widget dropDown(String selectedvalue)
  {

    return DropdownButton(
        value: selectedValue,
        onChanged: (String? newValue){
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: dropdownItems
    );
  }
}

