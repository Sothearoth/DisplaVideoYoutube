
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/style.dart';
import 'package:flutter_application_1/page/login.dart';
import 'package:flutter_application_1/utils/app_preference.dart';
import 'package:flutter_application_1/utils/navigate_custom.dart';
import 'package:flutter_application_1/widget/popup_dialog.dart';
import 'package:flutter_application_1/widget/sliver_appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  List<Map<String, dynamic>> settingList = [
    {"title": "Change Languguage", "icon": Icons.language},
    {"title": "About Us", "icon": Icons.info},
    {"title": "Logout", "icon": Icons.logout},
    {"title": "Upload Image", "icon": Icons.upload},
  ];

  File? _image;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: CustomScrollView(
          slivers: [
            CustomWidget.sliverAppBar(title: "Setting"),

            SliverList(
              delegate: SliverChildListDelegate([
                InkWell(
                  onTap: () async {
                    _image = await imageChooseDialog(context);
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2, right: MediaQuery.of(context).size.width * 0.2,),
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: _image != null ? Image(image: FileImage(_image!),) : const Center(child: Text('Choose Image')) ,
                  ),
                )
              ],
              ),
            ),


            SliverList(
                delegate: SliverChildBuilderDelegate(
              childCount: settingList.length,
              (context, index) {
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    if(index == 0){
                      PopupSetting().showSettingAlertDialog(context, "Change Language");
                    }else if (index == 1){
                      // about us click
                    }else if(index == 2){
                      AppPreference.clearLogin();
                      navigateTo(context, destination: const LoginScreen());
                    }else if (index == 3){
                      if(_image != null){
                        uploadImage(_image?.path);
                      }else{
                        print('Not pick image');
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Row(
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
                        Container(
                          margin: const EdgeInsets.only(top: 10),
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



  Future<void> uploadImage(filepath) async {

      var request = http.MultipartRequest('POST', Uri.parse('https://qacltom.udaya-tech.com/MacleLogistic/user/edit-user'));
      request.headers['Authorization'] = 'bearer fbf9dded-8ff3-4b79-860c-a974b57489aa';
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(await http.MultipartFile.fromPath('file', filepath));

      request.send().then((value) => {
        http.Response.fromStream(value).then((value) => {
          if(value.statusCode == 200){
            print(value.body)
          }else{
             throw Exception('Fail to load to server')
          }
        })
      });
  }



  static Future<File?> imageChooseDialog(context) async {

    File? _image;

    await showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        XFile? photo = await ImagePicker().pickImage(source: ImageSource.camera);
                        _image = File(photo!.path);
                        navigateBack(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(color: DefaultColor.primaryColor, borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.camera, color: Colors.white,),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Take Photo',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        XFile? photo = await ImagePicker().pickImage(source: ImageSource.gallery);
                        _image = File(photo!.path);
                        navigateBack(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(color: DefaultColor.primaryColor, borderRadius: BorderRadius.circular(5)),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.image, color: Colors.white,),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'From Device',
                                style: TextStyle(color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
    return _image;
  }

}
