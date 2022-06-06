import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SimpleImagePicker extends StatefulWidget {
  var pickedFile;

  SimpleImagePicker({Key? key, required this.pickedFile}) : super(key: key);

  @override
  State<SimpleImagePicker> createState() => _SimpleImagePickerState();
}

class _SimpleImagePickerState extends State<SimpleImagePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: widget.pickedFile != null
          ? Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              child: Image.file(File(widget.pickedFile!.path)))
          : Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 4),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Center(
                child: Text('Click here to pick image from Gallery'),
              ),
            ),
      onTap: () async {
        PickedFile? image =
            await ImagePicker().getImage(source: ImageSource.gallery);
        // var image = await ImagePicker().pickMultiImage();
        
      },
    );
  }
}
