import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:shared_preferences/shared_preferences.dart';

class QuilEditor extends StatefulWidget {
  const QuilEditor({Key? key}) : super(key: key);

  @override
  State<QuilEditor> createState() => _QuilEditorState();
}

class _QuilEditorState extends State<QuilEditor> {

  QuillController _controller = QuillController.basic();




  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(

      children: [
        QuillToolbar.basic(controller: _controller),
        Container(width: 411,height: 155,
          child: Expanded(
            child: Container(
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false, // true for view only mode
              ),
            ),
          ),
        ),


      ],
    ),);
  }
}
