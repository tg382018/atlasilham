import 'package:atlasilham/classes/categories.dart';
import 'package:atlasilham/screens/adminpages/login.dart';
import 'package:atlasilham/screens/main_screen.dart';
import 'package:flutter/material.dart';
import '../classes/categories.dart';
import '../classes/Items.dart';
import '../main.dart';
import '../screens/category_list_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget(
      {Key? key, required this.categoryList, required this.itemlist})
      : super(key: key);
  final Future<List<Kategoriler>> categoryList;
  final Future<List<Items>> itemlist;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  "https://ilhamatlasi.com/wp-content/uploads/2022/04/ilham-atlasi-logo-retina.png",
                  width: MediaQuery.of(context).size.width / 1.8,
                  alignment: Alignment.topRight,
                ),
                SizedBox(
                  width: 11,
                )
              ],
            ),
            SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  FutureBuilder(
                      future: widget.categoryList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Kategoriler> categList =
                              snapshot.data as List<Kategoriler>;
                          return Column(
                            children: [
                              SizedBox(
                                width: 11,
                                height: 11,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.home,
                                        color: Colors.atlasmavisi,
                                      ),
                                      title: Text(
                                        "Anasayfa",
                                        style: TextStyle(fontFamily: 'Poppins'),
                                      ),
                                      onTap: () {
                                        Navigator.of(
                                                context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MainScreen(
                                                            categoryList: widget
                                                                .categoryList,
                                                            itemlist: widget
                                                                .itemlist)),
                                                (Route<dynamic> route) =>
                                                    false);
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Renk Modu"),
                                      Switch(
                                          value: MyApp.of(context)!.darkTheme,
                                          onChanged: (state) {
                                            setState(() {
                                              MyApp.of(context)!.switcher();
                                            });
                                          }),
                                    ],
                                  )
                                ],
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: categList.length,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: Image.network(
                                            color: Colors.atlasmavisi,
                                            "${categList[i].kategori_resim}",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                          ),
                                          title: Text(
                                            "${categList[i].kategori_ad}",
                                            style: TextStyle(),
                                          ),
                                          onTap: () {
                                            String ktgKeyd =
                                                categList[i].kategori_ad;
                                            if (ktgKeyd == "Admin Paneli") {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Login()));
                                            } else if (ktgKeyd ==
                                                "Uygulama Hakkında") {
                                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>mainPage(katlist: widget.katlist, itemlist: widget.itemlist)));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CategoryList(
                                                              kategoriAd:
                                                                  ktgKeyd,
                                                              categoryList: widget
                                                                  .categoryList,
                                                              itemlist: widget
                                                                  .itemlist)));
                                            }
                                          },
                                        ),
                                        SizedBox(
                                          height: 11,
                                          width: 11,
                                        )
                                      ],
                                    );
                                  }),
                            ],
                          );
                        } else
                          return Container();
                      })
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
