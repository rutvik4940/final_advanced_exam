import 'package:finalexam/screen/cart/view/cart_screen.dart';
import 'package:finalexam/screen/home/view/home_screen.dart';
import 'package:finalexam/screen/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String,WidgetBuilder>app_routs={
  "/":(context)=>const SplashScreen(),
  "home":(context)=>const HomeScreen(),
  "cart":(context)=>const CartScreen(),
};