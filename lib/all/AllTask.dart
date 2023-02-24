import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/controller/homeController.dart';
import '../utils/db_helper.dart';

class Alltask extends StatefulWidget {
  const Alltask({Key? key}) : super(key: key);

  @override
  State<Alltask> createState() => _AlltaskState();
}

class _AlltaskState extends State<Alltask> {
  TextEditingController txttask = TextEditingController();
  TextEditingController txtcat = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    homeController.dataList.value = await Db_helper.db_helper.readdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade400,
          title: Text(
            "All Task",
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "New Task",
                  content: Column(
                    children: [
                      TextField(
                        controller: txttask,
                        decoration: InputDecoration(
                            hintText: "Your Task",
                            border: OutlineInputBorder()),
                      ),
                      TextField(
                        controller: txtcat,
                        decoration: InputDecoration(
                            hintText: "Category", border: OutlineInputBorder()),
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          Db_helper.db_helper
                              .insertdata(cat: txtcat.text, work: txttask.text);
                          homeController.dataList.value =
                          await Db_helper.db_helper.readdata();
                          txttask.clear();
                          txtcat.clear();
                          Get.back();
                        },
                        child: Text("Add")),
                    ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Cancel"))
                  ],
                );
              },
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
