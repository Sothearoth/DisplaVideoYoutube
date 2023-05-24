import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/style.dart';

class DisplayVideos extends StatefulWidget {
  const DisplayVideos({required this.title});
  final String title;

  @override
  _DisplayVideoState createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: DefaultColor.primaryColor),
        title: Text(
          widget.title,
          style: TextStyle(color: DefaultColor.primaryColor),
        ),
        backgroundColor: DefaultColor.secondaryColor,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 10, right: 10),
        height: 300,
        color: DefaultColor.primaryColor,
        child: Text(
          "Display video ",
        ),
      ),
    );
  }
}
