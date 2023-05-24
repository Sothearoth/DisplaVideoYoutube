import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';
import 'main_app.dart';

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
  String username = "user@gmail.com";
  String password = "user123";
  bool isHidden = true;

  login() {
    // if (usernameController.text == '' && passwordController.text == '') {
    //   setState(() {
    //     messageError = "Please enter your username and password.";
    //   });
    // } else if (usernameController.text == '' ||
    //     usernameController.text != username) {
    //   setState(() {
    //     invalidUser = "Invalid username";
    //     isInvalidUsername = true;
    //   });
    // } else if (passwordController.text == '' ||
    //     passwordController.text != password) {
    //   setState(() {
    //     messageError = "Invalid password";
    //   });
    // } else {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MainAppScreen(),
      ),
    );
    // }
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
              "Login",
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
                  hintText: "Username",
                  hintStyle: TextStyle(color: DefaultColor.secondaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
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
                style: TextStyle(color: Colors.red),
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    borderSide: BorderSide(color: DefaultColor.primaryColor),
                  ),
                ),
              ),
            ),
            Text(
              messageError,
              style: TextStyle(color: Colors.red),
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
                child: Text(
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
}
