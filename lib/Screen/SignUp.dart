
import 'package:admin_app/Screen/Home_Screen.dart';
import 'package:admin_app/db/auth.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/Screen/login_Screen.dart';


class SignUp extends StatefulWidget {
  // final Function toggleView;
  // SignUp(this.toggleView);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  final _firestore = FirebaseFirestore.instance;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: isLoading == false
          ? SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height - 50,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Enter UserName';
                        else if (value.length <= 4)
                          return 'UserName Must Be 4 Character Long ';
                        else
                          return null;
                      },
                      controller: userNameTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration('UserName'),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (val) {
                        return RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val) ?
                        null : "Enter correct email";
                      },
                      controller: emailTextEditingController,
                      style: simpleTextStyle(),
                      decoration: textFieldInputDecoration('Email'),
                    ),
                    SizedBox(height: 20,),
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
                    SizedBox(height: 20),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding:
                const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue.shade700,
                    elevation: 0.0,
                    child: MaterialButton(
                      onPressed: () async {
                          FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailTextEditingController.text, password: emailTextEditingController.text).then((signedInUser){
                                _firestore.collection("users").add({'email' : emailTextEditingController.text,"pass" : passwordTextEditingController.text}).then((value) {
                                  if(signedInUser != null)
                                    {
                                      Navigator.pushNamed(context,"/HomeScreen");
                                    }
                                }).catchError((e){
                                  print(e);
                                });


                          }).catchError((e){
                            print(e);
                          });

                        // print(emailTextEditingController.text);
                        // AuthMethod().createAccount(email: emailTextEditingController.text,password: passwordTextEditingController.text).then((value) {
                        //   if (value == "Account created") {
                        //     setState(() {
                        //       isLoading = false;
                        //     });
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 HomeScreen()));
                        //   } else {
                        //     setState(() {
                        //       isLoading =false;
                        //     });
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(content: Text(value)));
                        //   }
                        //
                        // });


                      },
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Text(
                        "SignUp",
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
              //         onPressed: () async {
              //           //  validateForm();
              //         },
              //         minWidth: MediaQuery
              //             .of(context)
              //             .size
              //             .width,
              //         child: Text(
              //           "SignUp with Google",
              //           textAlign: TextAlign.center,
              //           style: mediumTextStyle(),
              //         ),
              //       )),
              // ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already Have an Account ", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Login Now ", style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0, decoration: TextDecoration.underline),),

                    ),
                  )
                ],
              ),
              SizedBox(height: 200,),


            ],
          ),
        ),
      ) : Center(
          child: CircularProgressIndicator(),
      )

    );
  }
}
