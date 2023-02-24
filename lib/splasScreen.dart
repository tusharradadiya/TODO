import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/tabbarPage/tabbar.dart';

class Splasescreen extends StatefulWidget {
  const Splasescreen({Key? key}) : super(key: key);

  @override
  State<Splasescreen> createState() => _SplasescreenState();
}

class _SplasescreenState extends State<Splasescreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 3),
      () {
      Get.offNamed('tab');
      },
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal.shade700,
        body: Center(
          child: Column(
            children: [
              Spacer(),
              Text(
                "TaskMe",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1),
              ),
              Spacer(),
              Text(
                "powered by HNG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
