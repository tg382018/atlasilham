import 'package:atlasilham/components/drawer_widget.dart';
import 'package:atlasilham/firebase_process/firestore.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  var frtool = Firestore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
          categoryList: frtool.readCategory(), itemlist: frtool.readItem()),
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(
          "Uygulama Hakkında",
          style: TextStyle(fontSize: 17),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.menu_outlined),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 8,),
            Image.asset(
              "assets/images/y.png",
              width: 222,
              height: 222,
            ),
            SizedBox(height: 40,),
            Text(
              "Düşünmeye başlarsan ilham kapıları bir bir açılır.",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                  "İlham Atlası , insan haritalarından oluşmuş bir Atlas'tır.  Bu Atlas'ın içinde hem Mâsum Çocuk'lara hem de onların ebeveynleri olan siz yetişkinlere ve en önemlisi kendisini bulma yolunda olan yarının umudu gençlere yönelik üretimler yapılmaktadır.İlham Atlası, çocuklarımızın/gençlerimizin daha büyük bir zihin evreninde yaşamalarının yolunu açıyor. Kelimeler her çağda dünyayı değiştirmiştir. Eğitime ilham katmaya , zenginleştirilmiş içerikler ile eğitimde kaliteyi artırmaya ve bilgi çağında gökyüzüne sâkin olmaya ne dersiniz?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic)),
            ),
            Text("Öyleyse eğitiminize bir tutam ilham katın. İlhamla kalın...",
                style: TextStyle(fontStyle: FontStyle.italic)),


            SizedBox(height: 18,),

            Container(alignment: Alignment.topRight,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListTile(
                      leading: Image.network(
                        color: Colors.atlasmavisi,
                        "https://img.icons8.com/ios-glyphs/344/domain.png",
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            11,
                        height: MediaQuery.of(context)
                            .size
                            .height /
                            8,
                      ),
                      title: Text(
                        "Web Sitemiz",
                        style: TextStyle(),
                      ),
                      onTap: () {}),
                  ListTile(
                      leading: Image.network(
                        color: Colors.atlasmavisi,
                        "https://img.icons8.com/ios-glyphs/344/instagram-new.png",
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            11,
                        height: MediaQuery.of(context)
                            .size
                            .height /
                            8,
                      ),
                      title: Text(
                        "İnstagram Sayfamız",
                        style: TextStyle(),
                      ),
                      onTap: () {}),
                  ListTile(
                      leading: Image.network(
                        color: Colors.atlasmavisi,
                        "https://img.icons8.com/ios-glyphs/344/youtube-play.png",
                        width: MediaQuery.of(context)
                            .size
                            .width /
                            11,
                        height: MediaQuery.of(context)
                            .size
                            .height /
                            8,
                      ),
                      title: Text(
                        "Youtube Kanalımız",
                        style: TextStyle(),
                      ),
                      onTap: () {}),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
