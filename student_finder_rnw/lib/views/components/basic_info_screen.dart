import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';
import 'package:student_finder_rnw/globals/faculty_detail.dart';
import 'package:student_finder_rnw/views/components/my_header.dart';

class BasicInfo extends StatefulWidget {
  @override
  _BasicInfoState createState() => _BasicInfoState();
}

class _BasicInfoState extends State<BasicInfo> {
  StudentController studentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          // SliverPersistentHeader(
          //   delegate: MyHeader(),
          //   floating: true,
          //   pinned: true,
          // ),
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: Get.height * 0.32,
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("OK"),
              centerTitle: true,
              
              background: Material(
                shape: CircleBorder(),
                elevation: 3,
                child: Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.contain,
                      image: new NetworkImage(studentController.image.value),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => ListTile(
                title: Text(i.toString()),
              ),
            ),
          ),
        ],
      ),
    );

    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Stack(
          alignment: Alignment(0, Get.height * 0.015),
          children: [
            Container(
              margin: EdgeInsets.only(top: Get.width * 0.01),
              alignment: Alignment.center,
              height: Get.height * 0.25,
              width: Get.width * 0.98,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(1, 3),
                    color: Colors.black54,
                    blurRadius: 25,
                  ),
                ],
              ),
            ),
            Material(
              shape: CircleBorder(),
              elevation: 3,
              child: Container(
                height: Get.height * 0.23,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.contain,
                    image: new NetworkImage(studentController.image.value),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Chip(
        //   label: Text("Admission"),
        //   avatar: Text("2"),
        //   backgroundColor: Colors.amber,
        // ),
      ],
    );
  }
}
