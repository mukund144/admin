import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class PictureService{
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  String ref = "pictures";

  void uploadPicture({image}){
    // var id = Uuid();
    // String pictureId = id.v1();
    _firebaseFirestore.collection(ref).add({
      "image" : image
    }) .then((value) => print("Image Added"))
        .catchError((error) => print("Failed to add image: $error"));
  }

}