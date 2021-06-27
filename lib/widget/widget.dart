import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.redAccent,
    title: Center(child: Text("My App",style: TextStyle(color: Colors.black,),)),
  );
}

InputDecoration textFieldInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    hintStyle: TextStyle(color: Colors.white70),
    focusedBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
    enabledBorder:
    UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color:Colors.white70,
    fontSize: 17,
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 17.0);
}