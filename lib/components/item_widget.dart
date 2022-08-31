import 'package:atlasilham/screens/item_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/Items.dart';
import 'package:flutter/material.dart';
import '../classes/Items.dart';
import '../classes/categories.dart';

class itemWidgeti extends StatefulWidget {
  const itemWidgeti({Key? key,required this.item}) : super(key: key);
  final Items item;
  @override
  _itemWidgetiState createState() => _itemWidgetiState();
}

class _itemWidgetiState extends State<itemWidgeti> {
  String categicon="https://ilhamatlasi.com/wp-content/uploads/2022/07/1659036659145.jpg";



@override
  void initState() {
    // TODO: implement initState


}


  @override
  Widget build(BuildContext context) {



    return GestureDetector(child: Container(
      margin: EdgeInsets.all(11.0),
      padding: EdgeInsets.all(2.0),
      decoration:
      BoxDecoration( borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
          ]
      ),

      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: double.infinity,
                decoration: BoxDecoration(
                  image:
                  DecorationImage(image: NetworkImage(widget.item.item_resim),fit: BoxFit.fitWidth,),
                  borderRadius: BorderRadius.circular(13.0),
                ),),
            ),


            SizedBox(height: 2.0,),
            Container(alignment: Alignment.topRight,
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:5),
                    child: Text("${widget.item.kategori_ad}",style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(width: 8.0,),
                  Text(" - ${widget.item.item_baslik}",style: TextStyle(fontWeight: FontWeight.bold),),
                ],
              ),


                ],
              ),
            ),
            SizedBox(height: 3.0,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.item.item_konu,style: TextStyle(fontSize: 14.0,fontFamily: 'Poppins')),
            ),
            Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Row(
                  children: [
                    SizedBox(width: 5, ),
                    Icon(Icons.date_range),
                    Text("${widget.item.item_tarih.toString()}",textAlign: TextAlign.left,),
                  ],
                ),
                Text("Hafta ${widget.item.item_hafta}",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.w200),),
              ],
            ),),
            SizedBox(height: 6,)
          ],
        ),
      ),
    ) ,onTap: ()

    {

      Navigator.push(context, MaterialPageRoute(builder: (context){

        return ItemPage(item: widget.item);

      }


      ));
    }

      ,);
  }
}