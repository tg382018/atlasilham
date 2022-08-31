import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/Items.dart';
import '../classes/categories.dart';
import '../components/item_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.query,}) : super(key: key);
  final String query;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CollectionReference _firebaseFirestore =
  FirebaseFirestore.instance.collection("items");

  @override
  Widget build(BuildContext context) {
    return    Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          "Arama Sonuçları",
          style: TextStyle(),
        ),
        leading: Builder(
          builder: (context) => IconButton(
              icon: new Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
        ),

      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firebaseFirestore.snapshots().asBroadcastStream(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              print(snapshot.data);
              return ListView(children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                    element['item_baslik']
                        .toString()
                        .toLowerCase()
                        .contains(widget.query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String title = data.get('item_baslik');
                  var z = Items(
                      "item_id",
                      data.get('item_baslik'),
                      data.get('item_uzunmetin'),
                      data.get('item_konu'),
                      data.get('item_link'),
                      data.get('item_tarih'),
                      data.get('item_resim'),
                      data.get('item_hafta'),
                      data.get('kategori_ad'),
                      data.get('one_cikarilan'));
                  return itemWidgeti(item: z,);
                })
              ]);
            }
          }),
    );

  }
}
