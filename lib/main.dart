import 'package:finalexam/utils/app_routs/app_routs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: app_routs,
    ),
  );
}