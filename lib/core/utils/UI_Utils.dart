import 'package:evently_hti_sun/core/resources/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIUtils{
  static void showLoadingDialog(BuildContext context){
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context)=>CupertinoAlertDialog(

      content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(child: CircularProgressIndicator()),
      ],
    ),));
  }

static void hideDialog(BuildContext context){
    Navigator.pop(context);
}


static void showMessage(BuildContext context, String message){
    showDialog(context: context, builder: (context)=> CupertinoAlertDialog(
      content:  Text(message, style: TextStyle(fontSize: 16,color: ColorsManager.black, fontWeight: FontWeight.w400),),
    ));
}
}

