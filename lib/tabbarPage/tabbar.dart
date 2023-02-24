import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/all/AllTask.dart';

import '../home/view/homePage.dart';

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  List pagelist = [HomePage(), Alltask()];
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pagelist[i],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: i,
          onTap: (value) {
            setState(() {
              i = value;
            });
          },
          selectedIconTheme: IconThemeData(color: Colors.teal.shade500),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                size: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_month,
                size: 30,
              ),
              label: "All",
            )
          ],
        ),
      ),
    );
  }
}
