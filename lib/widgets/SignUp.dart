// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'dart:io';

import 'package:ebook/pages/home/main_book_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();
  PickedFile? pickedFile;
  PickedFile? imageUser;
  late ParseFileBase parseFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 350,
                  child: Image.network(
                      'https://ik.imagekit.io/aml28/DogiApp__2__zJl1hYcXv.png?ik-sdk-version=javascript-1.4.3&updatedAt=1652993161226'),
                ),
                Center(
                  child: const Text('User registration',
                      style: TextStyle(fontSize: 16)),
                ),
                SizedBox(
                  height: 16,
                ),
                TextField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Username'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'E-mail'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    PickedFile? image = await ImagePicker()
                        .getImage(source: ImageSource.gallery);

                    if (image != null) {
                      setState(() {
                        pickedFile = image;
                      });
                    }
                  },
                  child: pickedFile != null
                      ? Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue)),
                          child: Image.file(File(pickedFile!.path)))
                      : Container(
                          width: 200,
                          height: 150,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Center(
                            child: Text('Add Image'),
                          ),
                        ),
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () async {
                      parseFile = ParseFile(File(pickedFile!.path));
                      await Future.delayed(Duration(seconds: 2), () {});
                      addTodo(parseFile);
                      doUserRegistration();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void addTodo(ParseFileBase parsefile) async {
    await saveTodo(parsefile);
  }

  Future<void> saveTodo(ParseFileBase parseFile) async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

    await Future.delayed(Duration(seconds: 1), () {});
    final todo = ParseObject('UserImg')
      ..set('objectId', currentUser!.objectId)
      ..set('emailUser', currentUser.emailAddress)
      ..set('UserImage', parseFile);

    await todo.save();
  }

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: const Text("User was successfully created!"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);
    ParseCoreData().setSessionId('');

    var response = await user.signUp();

    if (response.success) {
      showSuccess();
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainBookPage(
                  userEmail: user.emailAddress,
                )),
      );
    } else {
      showError(response.error!.message);
    }
    //Sigup code here
  }
}
