import 'package:flutter/material.dart';

class DroppDown extends StatefulWidget {

  const DroppDown({Key? key}) : super(key: key);


  @override
  State<DroppDown> createState() => _DroppDownState();
}

class _DroppDownState extends State<DroppDown> {
  String selectedValue = "Cümle Atlası";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Cümle Atlası"),value: "Cümle Atlası"),
      DropdownMenuItem(child: Text("Şuur Atlası"),value: "Şuur Atlası"),
      DropdownMenuItem(child: Text("Sual Atlası"),value: "Sual Atlası"),
      DropdownMenuItem(child: Text("Hayret Atlası"),value: "Hayret Atlası"),
      DropdownMenuItem(child: Text("Kelime Atlası"),value: "Kelime Atlası"),
      DropdownMenuItem(child: Text("Film Atlası"),value: "Film Atlası"),
      DropdownMenuItem(child: Text("Kitap Atlası"),value: "Kitap Atlası"),
    ];
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        value: selectedValue,
        onChanged: (String? newValue){
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: dropdownItems
    );
  }
}
