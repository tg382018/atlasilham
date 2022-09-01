import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../classes/Items.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({Key? key,required this.item}) : super(key: key);
  final Items item;


  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {


  QuillController _controller = QuillController.basic();
  ScreenshotController sckon=ScreenshotController();


  void gelenikaydet(incomingJSONText)
  {
    var myJSON = jsonDecode(incomingJSONText);
    _controller = QuillController(
        document: Document.fromJson(myJSON),
        selection: TextSelection.collapsed(offset: 0));
  }

  @override
  void initState() {
    // TODO: implement initState
    gelenikaydet(widget.item.item_uzunmetin);
  }
  @override
  Widget build(BuildContext context) {
    return Screenshot(controller: sckon,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height/15,
          centerTitle: true,
          title: Text(widget.item.item_konu,style: TextStyle(),),
          leading:  Builder(
            builder: (context) => IconButton(
                icon: new Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context)
            ),
          ),

        ),

        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Container(
                height: MediaQuery.of(context).size.height/3,
                width: double.infinity,

                decoration:
                BoxDecoration(image:
                DecorationImage(image: NetworkImage(widget.item.item_resim),fit: BoxFit.fill,),
                  borderRadius: BorderRadius.circular(13.0),),

              ),
            ),
            Container(child: Padding(padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Row(children: [
                    Icon(Icons.account_tree),
                    Text(widget.item.kategori_ad,style: TextStyle(fontSize: 15),textAlign:TextAlign.right),],),


                  SizedBox(width: MediaQuery.of(context).size.width/3,),

                  Row(children: [
                    Icon(Icons.calendar_today),
                    Text(widget.item.item_tarih,style: TextStyle(fontSize: 15),),
                  ],),

                ],
              )
              ,),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.item.item_baslik,style: TextStyle(fontWeight: FontWeight.bold,fontSize:23),textAlign: TextAlign.center,)),
            ),
            QuillEditor(
              focusNode: FocusNode(),
              padding: EdgeInsets.all(0),
              autoFocus: false,
              scrollable: true,
              showCursor: false,
              controller: _controller,
              readOnly: true,
              expands: false,
              scrollController: ScrollController(),
              // true for view only mode
            ),
            SizedBox(height: MediaQuery.of(context).size.height/17,),
            Container(child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Icon(FontAwesomeIcons.link,size: MediaQuery.of(context).size.height/35,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Paylaşımı Web/İnsta sayfamızda incele ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,),textAlign:TextAlign.right),
                    ),

                  ],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end,children: [

                  Padding(padding: EdgeInsets.symmetric(vertical: 1,horizontal: 4),child: Icon(FontAwesomeIcons.whatsapp),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 1,horizontal: 4),child: Icon(FontAwesomeIcons.instagram),),
                  Padding(padding: EdgeInsets.symmetric(vertical: 1,horizontal: 4),child: Icon(FontAwesomeIcons.facebook),),
                  Padding(padding: EdgeInsets.all(8.0),
                    child: GestureDetector(child: Text("Sosyal Medyada Paylaş",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),onTap:() async{
                          final image=await sckon.capture();
                                if(image==null) return;
                                await saveImage(image);
                                saveAndShare(image);
                    }),),
                ],),
              ],
            ),),
          ],
        ),
      ),
    );


  }

Future<String> saveImage(Uint8List bytes) async
{
  await[Permission.storage].request();
  final result=await ImageGallerySaver.saveImage(bytes);
  return result['filePath'];

}

Future saveAndShare(Uint8List bytes) async
{
  final directory=await getApplicationDocumentsDirectory();
  final image=File('${directory.path}/flutter.png');
  image.writeAsBytesSync(bytes);
  final im='${widget.item.item_baslik} - İlham Atlası';
  await Share.shareFiles([image.path],text: im);
}
}

