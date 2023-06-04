import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/style.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/app_preference.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PopupSetting {

  Future showSettingAlertDialog(
    BuildContext context,
    String title,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => Stack(
        children: [
          AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(color: DefaultColor.primaryColor),
                ),
                _getCloseButton(context),
              ],
            ),
            content: Container(
              height: 150,
              child: SettingModul(),
            ),
          ),
        ],
      ),
    );
  }

  _getCloseButton(context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey.shade300,
        ),
        alignment: Alignment.topRight,
        child: GestureDetector(
          child: const Center(
            child: Icon(
              Icons.clear,
              color: Colors.grey,
              size: 22,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

class SettingModul extends StatefulWidget {
  const SettingModul({Key? key}) : super(key: key);

  @override
  _SettingModolState createState() => _SettingModolState();
}

class _SettingModolState extends State<SettingModul> {

  List<Map<String, dynamic>> languageList = [
    {
      "name": "English",
      "flag": "assets/images/american_flag.png",
    },
    {
      "name": "Khmer",
      "flag": "assets/images/cambodia_flag.png",
    },
  ];

  int currentLanguage = 0;

  @override
  void initState() {
    super.initState();

    updateLangStatus();

  }

  Future<void> updateLangStatus() async {

    if(AppPreference.getLanguage() == 'us'){
      currentLanguage = 0;
    }else{
      currentLanguage = 1;
    }
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: contentsLanguage(context),
    );
  }

  Widget contentsLanguage(BuildContext context) {
    return Container(
      width: 400,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          crossAxisCount: languageList.length,
        ),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              // Obtain shared preferences.

                currentLanguage = index;
                if(index == 0){
                  Get.updateLocale(Locale('en','US'));
                  AppPreference.saveLanguage('us');
                }else{
                  Get.updateLocale(Locale('kh','KH'));
                  AppPreference.saveLanguage('kh');
                }
                navigator?.pop(context);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: DefaultColor.primaryColor,
                    width: currentLanguage == index ? 1.5 : 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: const EdgeInsets.only(right: 5, top: 5),
                        child: currentLanguage == index
                            ? Icon(Icons.check_circle,
                                color: DefaultColor.primaryColor)
                            : const Icon(Icons.check_circle,
                                color: Colors.white)),
                  ),
                  SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(languageList[index]['flag'])),
                  Text(
                    languageList[index]['name'],
                    style: TextStyle(color: DefaultColor.primaryColor),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
