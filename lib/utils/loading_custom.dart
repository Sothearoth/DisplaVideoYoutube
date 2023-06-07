import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/navigate_custom.dart';

class LoadingCustom{

  void loadingShow(context){
    showDialog(
      barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.8),
        context: context,
        builder:(context){

          return Center(
            child: CircularProgressIndicator(),
          );
    });
  }


  void loadingDismiss(context){
    navigateBack(context);
  }

}