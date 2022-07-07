
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class storage extends StatefulWidget {
  const storage({Key? key}) : super(key: key);

  @override
  State<storage> createState() => _storageState();
}

class _storageState extends State<storage> {

  final ImagePicker _picker = ImagePicker();

  String path = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("image picker"),),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 150,
            color: Colors.lightBlue,
            margin: EdgeInsets.all(20),
          ),
          Image.file(File(path),height: 200,width: 200,),

          OutlineButton(onPressed: () {
            showDialog(builder: (context) {
              return SimpleDialog(
                title: Text("Select image"),
                children: [
                  ListTile(onTap: () async {
                    Navigator.pop(context);
                    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                    path=photo!.path;
                    setState(() {

                    });
                  },title: Text("Camera"),),
                  ListTile(onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                    path=image!.path;
                    setState(() {

                    });
                  },title: Text("Gallery"),),

                ],
              );

            },context: context);

          },child: Text("Choose File"),),

          ElevatedButton(onPressed: () async {
            final storageRef = FirebaseStorage.instance.ref();

            String imagename = path.split("/").last;

            final mountainImagesRef = storageRef.child("images/$imagename");

            try {
              mountainImagesRef.putFile(File(path));
            } on FirebaseException catch (e) {
            }
          }, child: Text("Send"))
        ],
      ),
    );
  }
}

