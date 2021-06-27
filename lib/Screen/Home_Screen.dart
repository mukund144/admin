

import 'dart:io';

import 'package:admin_app/db/picture.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin_app/Screen/login_Screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PictureService productService = PictureService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color red = Colors.red;
  File _image;
  final picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.redAccent,
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: (){
                FirebaseAuth.instance.signOut().then((value){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                });
              },
                child: Icon(Icons.logout,color: Colors.black,),
            ),
          ),
        ],

        title: Center(
          child: Text(
            "Add Picture",
            style: TextStyle(
                color: black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: OutlineButton(
                            borderSide: BorderSide(
                                color: black.withOpacity(0.8), width: 2),
                            onPressed: () {
                              _selectImage();
                            },
                            child: _displayChild1()
                        ),
                      ),
                    ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: OutlineButton(
                    //       borderSide: BorderSide(
                    //           color: black.withOpacity(0.8), width: 1.5),
                    //       onPressed: () {
                    //    _selectImage(ImagePicker.pickImage(source: ImageSource.gallery));
                    //       },
                    //       child: Padding(
                    //         padding: EdgeInsets.fromLTRB(14, 50, 14, 50),
                    //         child: Icon(Icons.add,color: Colors.black,),
                    //       ),
                    //       //
                    //       //  child: _displayChild2()
                    //     ),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(8.0),
                    //     child: OutlineButton(
                    //       borderSide: BorderSide(
                    //           color: black.withOpacity(0.8), width: 1.5),
                    //       onPressed: () {
                    //         //   _selectImage(ImagePicker.pickImage(source: ImageSource.gallery), 3);
                    //       },
                    //       child: Padding(
                    //         padding: EdgeInsets.fromLTRB(14, 50, 14, 50),
                    //         child: Icon(Icons.add,color: Colors.black,),
                    //       ),
                    //       //
                    //       //   child: _displayChild3(),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
//
                SizedBox(height: 20,),
                // FlatButton(
                //   color: black,
                //   textColor: white,
                //   child: Text('Add Picture', style: TextStyle(fontSize: 18),),
                //   onPressed: () {
                //     validateAndUpload();
                //   },
                // ),
                Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black,
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: () async{
                          validateAndUpload();
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },

                        child: Text(
                          "Add Picture",
                          textAlign: TextAlign.center,
                          style: mediumTextStyle(),
                        ),
                      )),

              ],
            ),
          ),
        ),
      ),
    );
  }







  Widget _displayChild1() {
    if(_image == null){
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 100, 14, 100),
        child: new Icon(Icons.add_a_photo_sharp, color: Colors.black,),
      );
    }
    else{
      return Image.file(_image, fit: BoxFit.fill, width: double.infinity,);
    }
  }

  void _selectImage() async{
    final image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }

  Future validateAndUpload() async {
    if(_formKey.currentState.validate())
    {
      if(_image != null) {
        String imageUrl;
        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture = "${DateTime
            .now()
            .millisecondsSinceEpoch
            .toString()}.jpg";
        print(picture);
        Reference ref= storage.ref().child("images/$picture");
        UploadTask task = ref.putFile(_image);
        // TaskSnapshot snapshot = await task.onComplete.then((
        //     snapshot) => snapshot);
        TaskSnapshot taskSnapshot = await task.whenComplete((){});
        imageUrl = await taskSnapshot.ref.getDownloadURL();
        String url = imageUrl.toString();

        //   imageUrl = await ref.getDownloadURL().then((value) => print("Done : $value"),);
        //   print(imageUrl);
          // String url = imageUrl.toString();
          // print("++++++++++");
          // print(url);
          // String imageList = url;
          // productService.uploadPicture(image: imageUrl);

             _formKey.currentState.reset();
             Fluttertoast.showToast(msg: "Picture Added Successfully");
          // return url;




          // });
      }
      else{
        Fluttertoast.showToast(msg: "Please Select Image...");

      }
    }

  }
}
