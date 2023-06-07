
import 'dart:convert';
import 'dart:io';


import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/app_preference.dart';
import 'package:flutter_application_1/utils/global_function.dart';
import 'package:flutter_application_1/utils/loading_custom.dart';
import 'package:flutter_application_1/utils/navigate_custom.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'color.dart';
import 'main_app.dart';
import 'model/login/login_response.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String invalidUser = "";
  String messageError = "";
  bool isInvalidUsername = false;
  String username = "U";
  String password = "";
  bool isHidden = true;

  login() async {
    if (usernameController.text == '' && passwordController.text == '') {
      setState(() {
        messageError = "Please enter your username and password.";
      });
    } else if (usernameController.text == '') {
      setState(() {
        invalidUser = "Invalid username";
        isInvalidUsername = true;
      });
    } else if (passwordController.text == '') {
      setState(() {
        messageError = "Invalid password";
      });
    } else {

      LoadingCustom().loadingShow(context);
      LoginResponse response = await loginRequest( await getDeviceId(), await getDeviceName(), passwordController.text , usernameController.text);
      if(response.header?.statusCode == 200 && response.header?.result == true){
        AppPreference.saveLogin(true);
        LoadingCustom().loadingDismiss(context);
        navigateTo(context, destination: const MainAppScreen());
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Fail!')));
        LoadingCustom().loadingDismiss(context);
      }
     }
  }



  @override
  void initState() {
    super.initState();
    checkLang();
  }

  void checkLang()  {
    if(AppPreference.getLanguage() == 'kh'){
      Get.updateLocale(const Locale('kh', 'KH'));
    }else{
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header login
            Text(
              "Login".tr,
              style: TextStyle(
                  color: DefaultColor.primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            // username input form field
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: DefaultColor.secondaryColor,
                  ),
                  hintText: "Username".tr,
                  hintStyle: TextStyle(color: DefaultColor.secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: isInvalidUsername,
              child: Text(
                invalidUser,
                style: const TextStyle(color: Colors.red),
              ),
            ),

            // password

            Container(
              margin: const EdgeInsets.only(top: 20),
              child: TextFormField(
                obscureText: isHidden,
                controller: passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isHidden ? isHidden = false : isHidden = true;
                        });
                      },
                      icon: isHidden
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: DefaultColor.secondaryColor,
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: DefaultColor.secondaryColor,
                            )),
                  prefixIcon: Icon(
                    Icons.key,
                    color: DefaultColor.secondaryColor,
                  ),
                  hintText: "Password",
                  hintStyle: TextStyle(color: DefaultColor.secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                messageError,
                style: const TextStyle(color: Colors.red),
              ),
            ),

            // button forget pw
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // push to Forget Password screen
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  "Forget Password ?",
                  style: TextStyle(color: DefaultColor.primaryColor),
                ),
              ),
            ),

            // login button

            InkWell(
              onTap: () {
                login();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                height: 45,
                width: double.infinity,
                child: const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                decoration: BoxDecoration(
                  color: DefaultColor.primaryColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      offset: const Offset(0, 2),
                      spreadRadius: 5,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  loginRequest(String deviceId, String deviceName, String password, String username) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://qacltom.udaya-tech.com/MacleLogistic/auth/login'));

    request.fields['deviceId'] = deviceId;
    request.fields['deviceName'] = deviceName;
    request.fields['password'] = password;
    request.fields['username'] = username;

    final response = await http.Response.fromStream( await request.send());

    if(response.statusCode == 200){
      print(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fail to load to server');
    }
  }



}

