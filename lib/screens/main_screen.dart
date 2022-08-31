import 'package:atlasilham/screens/search_page.dart';
import '../classes/categories.dart';
import '../classes/Items.dart';
import 'package:atlasilham/components/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../components/item_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(
      {Key? key, required this.categoryList, required this.itemlist})
      : super(key: key);

  final Future<List<Kategoriler>> categoryList;
  final Future<List<Items>> itemlist;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var searchtext = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
          categoryList: widget.categoryList, itemlist: widget.itemlist),
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          "Ana Sayfa",
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
        physics: ScrollPhysics(),
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
                            if (searchtext.text == "Arama Yapın") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Aramak icin kelime girmediniz")));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage(
                                            query: searchtext.text,
                                          ))).then(
                                  (value) => searchtext.text = "Arama Yapın");
                            }
                          })
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        "Öne Çıkarılanlar",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(11),
                    ),
                  ],
                ),
                FutureBuilder(
                    future: widget.itemlist,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Items> itemliste = snapshot.data as List<Items>;
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: itemliste.length,
                            itemBuilder: (context, i) {
                              if (itemliste != null) {
                                if (itemliste[i].one_cikarilan = true) {
                                  Items z = itemliste[i];
                                  return itemWidgeti(
                                    item: z,
                                  );
                                } else {
                                  return Container(
                                    child: Text(""),
                                  );
                                }
                              } else {
                                return Container(
                                  child: Text("HATA,Uygulamayı Tekrar Başlatın"),
                                );
                              }
                            });
                      } else {
                        return Container(
                          child: Text("Yükleniyor..."),
                        );
                      }
                    })
              ],
            ),
            //  itemWidget(item1,context),
          ],
        ),
      ),
    );
  }
}
