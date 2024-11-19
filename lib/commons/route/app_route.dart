import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute{

  void navigateTo(BuildContext context, Widget widget){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return widget;
    }));

  }

}