import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_finder_rnw/controllers/student_controller.dart';

class MyHeader extends SliverPersistentHeaderDelegate {
  StudentController studentController = Get.find();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Center(
          child: Material(
            shape: CircleBorder(),
            elevation: 3,
            child: Container(
              height: Get.height * 0.18,
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
    );
  }

  @override
  double get maxExtent => Get.height*0.32;

  @override
  double get minExtent => Get.height*0.085;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
