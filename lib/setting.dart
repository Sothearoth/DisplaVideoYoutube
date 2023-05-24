import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/style.dart';
import 'package:flutter_application_1/widget/popup_dialog.dart';
import 'package:flutter_application_1/widget/sliver_appbar.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<Map<String, dynamic>> settingList = [
    {"title": "Change Languguage", "icon": Icons.language},
    {"title": "About Us", "icon": Icons.info},
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            CustomWidget.sliverAppBar(title: "Setting"),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: settingList.length,
              (context, index) {
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    print(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    settingList[index]['icon'],
                                    color: DefaultColor.primaryColor,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      settingList[index]['title'],
                                      style: TextStyle(
                                          color: DefaultColor.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                                color: DefaultColor.primaryColor,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            height: 1,
                            color: DefaultColor.primaryColor,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
