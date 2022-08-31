
import 'package:atlasilham/classes/Items.dart';
import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/components/drawer_widget.dart';
import 'package:flutter/material.dart';

import '../main_screen.dart';
import 'add_item.dart';
import 'add_del_category.dart';
import 'del_item.dart';

class mainPage extends StatefulWidget {
  const mainPage({Key? key, required this.katlist, required this.itemlist})
      : super(key: key);
  final Future<List<Kategoriler>> katlist;
  final Future<List<Items>> itemlist;

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: DrawerWidget(
          categoryList: widget.katlist,
          itemlist: widget.itemlist,
        ),
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          title: Text(
            "Admin İslemleri",
            style: TextStyle(fontSize: 17),
          ),
          leading: Builder(
            builder: (context) => IconButton(
                icon: new Icon(Icons.arrow_back_ios),
                onPressed: () =>       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    MainScreen(categoryList: widget.katlist, itemlist: widget.itemlist)), (Route<dynamic> route) => false)),
          ),

        ),
        bottomNavigationBar: menu(),
        body: TabBarView(

          children: [
            addDelCategory(katlist: widget.katlist, itemlist: widget.itemlist),
            addItem(katlist: widget.katlist, itemlist: widget.itemlist),
            delItem(katlist: widget.katlist, itemlist: widget.itemlist),
          ],
        ),
      ),
    );
  }
}

Widget menu() {
  return TabBar(

    tabs: [
      Tab(
        text: "Kategori Ekle/Sil",
        icon: Icon(Icons.add),
      ),
      Tab(
        text: "Paylasım Ekle",
        icon: Icon(Icons.add_box),
      ),
      Tab(
        text: "Paylasım Sil",
        icon: Icon(Icons.delete_outlined),
      ),
    ],
  );
}
