import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          return Column(
            children: [
              Container(
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  height: 100,
                  child: (controller.number.isEmpty)
                      ? Container()
                      : GridView.builder(
                          itemCount: controller.number.length,
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              color: Colors.orange,
                              child: Draggable(
                                data: [
                                  controller.number[index],
                                ],
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 50,
                                  child: Text(
                                    "${controller.number[index]}",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                feedback: Container(
                                  height: 100,
                                  width: 100,
                                  child: Scaffold(
                                    body: Container(
                                      height: 100,
                                      width: 100,
                                      alignment: Alignment.center,
                                      color: Colors.orange,
                                      child: Text(
                                        "${controller.number[index]}",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                onDragCompleted: () {
                                  controller.number.removeAt(index);
                                },
                                maxSimultaneousDrags: 1,
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 3)),
                ),
              ),
              Spacer(),
              Container(
                child: DragTarget<List>(
                  builder: (context, List<dynamic> candidateData,
                      List<dynamic> rejectedData) {
                    return Container(
                      height: 100,
                      color: Colors.green[100],
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 100,
                        child: (controller.dragNumber.isEmpty)
                            ? Container()
                            : GridView.builder(
                                itemCount: controller.dragNumber.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: Colors.orange,
                                    child: Draggable(
                                      data: controller.dragNumber[index],
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 50,
                                        width: 50,
                                        child: Text(
                                          "${controller.dragNumber[index]}",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      feedback: Container(
                                        height: 100,
                                        width: 100,
                                        child: Scaffold(
                                          body: Container(
                                            height: 100,
                                            width: 100,
                                            alignment: Alignment.center,
                                            color: Colors.orange,
                                            child: Text(
                                              "${controller.dragNumber[index]}",
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onDragStarted: () {
                                        controller.condition.value = true;
                                      },
                                      onDraggableCanceled: (velocity, offset) {
                                        controller.condition.value = false;
                                      },
                                      onDragCompleted: () {
                                        controller.dragNumber.removeAt(index);
                                      },
                                    ),
                                  );
                                },
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 3)),
                      ),
                    );
                  },
                  onWillAccept: (data) {
                    controller.number.remove(data);
                    String acceptData = data![0].toString();
                    print(acceptData);
                    controller.dragNumber.add(acceptData);
                    print(controller.dragNumber);
                    print("object");
                    return true;
                  },
                  onAccept: (data) {
                    print("object");
                  },
                ),
              ),
              Spacer(),
              (controller.condition.isFalse)
                  ? Container()
                  : Container(
                      child: DragTarget<String>(
                        builder: (context, List<dynamic> candidateData,
                            List<dynamic> rejectedData) {
                          return Container(
                            height: 100,
                            width: 100,
                            child: Icon(Icons.delete_outline),
                          );
                        },
                        onWillAccept: (data) {
                          controller.dragNumber.remove(data);
                          String acceptData = data![0].toString();
                          print(acceptData);
                          controller.number.add(acceptData);
                          print(controller.number);
                          print("object");
                          controller.condition.value = false;
                          return true;
                        },
                        onAccept: (data) {
                          print("object");
                        },
                      ),
                    ),
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}
