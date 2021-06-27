

import 'package:admin_app/Screen/SignUp.dart';
import 'package:admin_app/db/auth.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/Screen/Home_Screen.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  bool isLoding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: isLoding == false
            ? SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 120,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter correct email";
                              },
                              controller: emailTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration('Email'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length < 6
                                    ? "Password Must be 6 Character Long"
                                    : null;
                              },
                              controller: passwordTextEditingController,
                              style: simpleTextStyle(),
                              decoration: textFieldInputDecoration('Password'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Container(
                      //   child: Container(
                      //     alignment: Alignment.centerRight,
                      //     child: Text("Forgot Password   ",style: simpleTextStyle(),),
                      //   ),
                      // ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.blue.shade700,
                            elevation: 0.0,
                            child: MaterialButton(
                              onPressed: () async {
                                setState(() {
                                  isLoding = true;
                                });
                                print("++++++++++++++++++++++");
                                print(emailTextEditingController.text);
                                print(passwordTextEditingController.text);
                                AuthMethod()
                                    .logIN(
                                        email: emailTextEditingController.text,
                                        password: passwordTextEditingController
                                            .text)
                                    .then((value) {
                                  if (value == "Welcome") {
                                    setState(() {
                                      isLoding = false;
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(value)));
                                  }
                                });
                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                              },
                              minWidth: MediaQuery.of(context).size.width,
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: mediumTextStyle(),
                              ),
                            )),
                      ),
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      //   child: Material(
                      //       borderRadius: BorderRadius.circular(20.0),
                      //       color: Colors.red.shade500,
                      //       elevation: 0.0,
                      //       child: MaterialButton(
                      //         onPressed: () async{
                      //           //  validateForm();
                      //         },
                      //         minWidth: MediaQuery.of(context).size.width,
                      //         child: Text(
                      //           "Login with Google",
                      //           textAlign: TextAlign.center,
                      //           style: mediumTextStyle(),
                      //         ),
                      //       )),
                      // ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have Account ? ",style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0),),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> SignUp()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text("Register Now ",style:TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,decoration: TextDecoration.underline),),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 200,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
    ;
  }
}
