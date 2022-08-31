import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/components/drawer_widget.dart';
import 'package:atlasilham/screens/search_page.dart';
import 'package:flutter/material.dart';

import '../classes/Items.dart';
import '../components/item_widget.dart';

class CategoryList extends StatefulWidget {
  const CategoryList(
      {Key? key,
      required this.kategoriAd,
      required this.categoryList,
      required this.itemlist})
      : super(key: key);
  final String kategoriAd;
  final Future<List<Kategoriler>> categoryList;
  final Future<List<Items>> itemlist;

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  var searchtext = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
          categoryList: widget.categoryList, itemlist: widget.itemlist),
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          widget.kategoriAd,
          style: TextStyle(fontSize: 17),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu_outlined),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 13,
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Arama yapın",
                          ),
                          controller: searchtext,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (searchtext.text == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Aramak icin kelime girmediniz")));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchPage(
                                          query: searchtext.text,
                                        )));
                          }
                        })
                  ],
                ),
              ),
            ],
          ),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                      future: widget.itemlist,
                      builder: (context, snapshot) {
                        List<Items> itemliste = snapshot.data as List<Items>;
                        for (int j = 0; j < itemliste.length - 1; j++) {
                          for (int i = 0; i < itemliste.length - 1; i++) {
                            if (int.parse(itemliste[i].item_hafta) >
                                int.parse(itemliste[i + 1].item_hafta)) {
                              Items gecici = itemliste[i];
                              itemliste[i] = itemliste[i + 1];
                              itemliste[i + 1] = gecici;
                            }
                          }
                        }
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: itemliste.length,
                            itemBuilder: (context, i) {
                              if (widget.kategoriAd ==
                                  itemliste[i].kategori_ad) {
                                Items it = itemliste[i];

                                return itemWidgeti(
                                    item:
                                        it); //Container(child: Text("${itemListem[indeks].item_id}",style: TextStyle(color: Colors.white),));
                                // Items itm=itemListem[indeks];
                                //return itemWidget(itm);
                              } else {
                                return Container();
                              }
                            });
                      })
                ],
              )),
        ],
      )),
    );
  }
}
