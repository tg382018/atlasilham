import 'package:atlasilham/classes/Items.dart';
import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/firebase_process/firestore.dart';
import 'package:flutter/material.dart';


class addDelCategory extends StatefulWidget {
  const addDelCategory(
      {Key? key, required this.katlist, required this.itemlist})
      : super(key: key);
  final Future<List<Kategoriler>> katlist;
  final Future<List<Items>> itemlist;

  @override
  _addDelCategoryState createState() => _addDelCategoryState();
}

class _addDelCategoryState extends State<addDelCategory> {
  var kn1 = TextEditingController();
  var kn2 = TextEditingController();
  var kn3 = TextEditingController();
  var kn4 = TextEditingController();
  var kn5 = TextEditingController();
  var kn6 = TextEditingController();
  var dbt = Firestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(
                  "Kategori Ekleme",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 21),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            Container(

                child: TextField(
                  controller: kn1,
                  decoration:
                  InputDecoration(hintText: "Kategori Sirasi Giriniz(Menüdeki liste bu sıraya göre dizilir)"),
                )),
            Container(

                child: TextField(
                  controller: kn2,
                  decoration: InputDecoration(hintText: "Kategori Adı Giriniz"),
                )),
            Container(

                child: TextField(
                  controller: kn3,
                  decoration: InputDecoration(
                      hintText: "Kategori icin resim url giriniz"),
                )),
            RaisedButton(

                child: Text(
                  "Kategori Ekle",
                ),
                onPressed: () {
                  int df = int.parse(kn1.text);
                  String a = kn2.text;
                  String b = kn3.text;
                  dbt.addCategory(df, a, b);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kategori Eklendi")));
                }),
            Container(
              child: Text(
                "Kategori Sil",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 21),
              ),
              alignment: Alignment.topLeft,
            ),
            FutureBuilder(
                future: widget.katlist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Kategoriler> catlist =
                    snapshot.data as List<Kategoriler>;
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: catlist.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 11,

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(11),
                                    topLeft: Radius.circular(11))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${catlist[i].kategori_ad}--- Sırası :${catlist[i].kategori_sirasi} "),
                                SizedBox(
                                  width: 11,
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: RaisedButton(
                                      child: Icon(Icons.delete_outline_rounded),
                                      onPressed: () {
                                        dbt.delCategory(
                                            catlist[i].kategori_key);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content:
                                            Text("Kategori Silindi")));
                                      }),
                                ),
                              ],
                            ),
                          );
                        });
                  } else
                    return Container(
                      child: Text("Veri akışı hatası"),
                    );
                }),
          ],
        ),
      ),
    );
  }
}
