import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/home/controller/homeController.dart';
import 'package:todo/utils/db_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txttask = TextEditingController();
  TextEditingController txtcat = TextEditingController();
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    getdata();
    getdonedata();
  }

  Future<void> getdata() async {
    homeController.dataList.value = await Db_helper.db_helper.readdata();
  }

  Future<void> getdonedata() async {
    homeController.dataList2.value = await Db_helper.db_helper.readdonedata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade400,
          title: Text(
            "Today, February ${DateTime.now().day}",
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
        backgroundColor: Colors.black12,
        body: Column(
          children: [
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Obx(
                () => Text(
                  "  TODO (${homeController.dataList.length})",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: homeController.dataList.length,
                  itemBuilder: (context, index) => Container(
                    height: 70,
                    color: Colors.white,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      title: Text(
                        "${homeController.dataList[index]['cat']}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${homeController.dataList[index]['work']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              Db_helper.db_helper.insertdonedata(
                                  cat: homeController.dataList[index]['cat'],
                                  work: homeController.dataList[index]['work']);
                              Db_helper.db_helper.deletedata(
                                  id: homeController.dataList[index]['id']);
                              getdata();
                              getdonedata();
                            },
                            icon: Icon(Icons.done),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () async {
                              Db_helper.db_helper.deletedata(
                                  id: homeController.dataList[index]['id']);
                              homeController.dataList.value =
                                  await Db_helper.db_helper.readdata();
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Obx(
                () => Text(
                  "  DONE (${homeController.dataList2.length})",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: homeController.dataList2.length,
                  itemBuilder: (context, index) => Container(
                    height: 70,
                    color: Colors.white,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      title: Text(
                        "${homeController.dataList2[index]['cat']}",
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${homeController.dataList2[index]['work']}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Db_helper.db_helper.deletedonedata(
                                  id: homeController.dataList2[index]['id']);
                              getdata();
                              getdonedata();
                            },
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
