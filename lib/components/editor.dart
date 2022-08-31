import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zefyrka/zefyrka.dart';
class Editor extends StatefulWidget {
  const Editor({Key? key}) : super(key: key);

  @override
  State<Editor> createState() => _EditorState();
}

class _EditorState extends State<Editor> {
  ZefyrController _controller = ZefyrController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 111,),
            ZefyrToolbar.basic(controller: _controller),
            Container(decoration: BoxDecoration(border: Border.all(color: Colors.black)),width: 311,
              height: 211,
              child: Expanded(
                child: ZefyrEditor(


                  controller: _controller,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
