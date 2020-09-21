import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:got_2/got_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: CupertinoColors.destructiveRed,
        fontFamily: "Pacifico"
        

      ),
      home: GotPage(),
    );
  }
}
