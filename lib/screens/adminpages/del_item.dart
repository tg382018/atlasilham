import 'package:atlasilham/classes/Items.dart';
import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/firebase_process/firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class delItem extends StatefulWidget {
  const delItem({Key? key, required this.katlist, required this.itemlist})
      : super(key: key);
  final Future<List<Kategoriler>> katlist;
  final Future<List<Items>> itemlist;

  @override
  _delItemState createState() => _delItemState();
}

class _delItemState extends State<delItem> {
  var dbt = Firestore();

  @override
  void initState() {
    // TODO: implement initState
    widget.itemlist;
  }

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
                  "Paylaşım Sil",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 21),
                ),
                alignment: Alignment.topLeft,
              ),
            ),
            FutureBuilder(
                future: widget.itemlist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Items> itlist = snapshot.data as List<Items>;
                    return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: itlist.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 111,
                            child: Card(

                              elevation: 21,

                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(11),
                                      topLeft: Radius.circular(11))),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      itlist[i].item_baslik,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  RaisedButton(
                                      child: Icon(Icons.delete_outline_rounded),
                                      onPressed: () {

                                        dbt.delItem(itlist[i].item_id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                            content:
                                            Text("Paylaşım Silindi,işlemin görükmesi için uygulamayı komple kapatıp tekrar açın")));
                                      })
                                ],
                              ),
                            ),
                          );
                        });
                  } else
                    return Container(
                      child: Text("Veri akışı hatası"),
                    );
                })
          ],
        ),
      ),
    );
  }
}
