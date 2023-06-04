
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future navigateTo(BuildContext context, {required Widget destination}){
  return Navigator.of(context).push(MaterialPageRoute(builder: (_)=> destination));
}

void navigateBack(BuildContext context){
  return Navigator.pop(context);
}