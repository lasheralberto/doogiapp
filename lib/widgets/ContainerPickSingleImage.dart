import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class SimpleImagePicker extends StatefulWidget {
  //var pickedFile;
  const SimpleImagePicker({
    Key? key,
    //required this.pickedFile
  }) : super(key: key);

  @override
  State<SimpleImagePicker> createState() => _SimpleImagePickerState();
}

class _SimpleImagePickerState extends State<SimpleImagePicker> {
  @override
  var pickedFile;
  var parseFile;

  void addImg(ParseFileBase img) async {
    await saveUserImg(img);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            child: pickedFile != null
                ? Container(
                    width: 250,
                    height: 250,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.blue)),
                    child: Image.file(File(pickedFile!.path)))
                : Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 4),
                        borderRadius: const BorderRadius.all(Radius.circular(20))),
                    child: const Center(
                      child: Text('Click here to pick image from Gallery'),
                    ),
                  ),
            onTap: () async {
              var image =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  pickedFile = image;
                  parseFile = ParseFile(File(pickedFile!.path));
                });
              }
            },
          ),
          SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () async {
                  //Flutter Mobile/Desktop
                  parseFile = ParseFile(File(pickedFile!.path));
    
                  await Future.delayed(const Duration(seconds: 1), () {});
                  addImg(parseFile);
                  Navigator.of(context).pop();
                  
                },
                child: const Text('Submit'),
              ))
        ],
      ),
    );
  }
}

Future<void> saveUserImg(
  ParseFileBase parseFile,
) async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

  await Future.delayed(const Duration(seconds: 2), () {});
  final todo = ParseObject('UserImg')
    //..set('objectId', currentUser!.objectId)
    ..set('emailUser', currentUser!.emailAddress)
    ..set('UserImage', parseFile);

  await todo.save();
}
