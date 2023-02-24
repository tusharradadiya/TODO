import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/home/view/homePage.dart';
import 'package:todo/splasScreen.dart';
import 'package:todo/tabbarPage/tabbar.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Splasescreen(),
        'home': (context) => HomePage(),
        'tab': (context) => Tabbar(),
      },
    ),
  );
}
