// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, use_key_in_widget_constructors, sized_box_for_whitespace, file_names

import 'package:ebook/pages/home/main_book_page.dart';
import 'package:ebook/widgets/SignUp.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageeState createState() => _LoginPageeState();
}

class _LoginPageeState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

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
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.network(AppConstants.APPLOGO5),
                ),
                // Center(
                //   child:
                //       //const Text('User Login', style: TextStyle(fontSize: 14)),
                // ),
                SizedBox(height: 40),
                TextField(
                  controller: controllerEmail,
                  enabled: !isLoggedIn,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          gapPadding: 5.0,
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Email'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: controllerPassword,
                  enabled: !isLoggedIn,
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.none,
                  autocorrect: false,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.black)),
                      labelText: 'Password'),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        maximumSize: Size.fromHeight(60),
                        minimumSize: Size.fromHeight(50),
                        visualDensity: VisualDensity.compact,
                        splashFactory: InkRipple.splashFactory,
                        enableFeedback: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Login'),
                    onPressed: () {
                      // isLoggedIn == false ? () => doUserLogin() : null ;
                      doUserLogin();
                    }),
                SizedBox(
                  height: 5,
                ),
                Container(
                    height: 50,
                    child: TextButton(
                        child: const Text('Sign Up?'),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SignUp();
                            },
                          ));
                        }))
              ],
            ),
          ),
        ));
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
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
            TextButton(
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

  void doUserLogin() async {
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(email, password, null);

    var response = await user.login();

    if (response.success) {
      showSuccess("User was successfully login!");
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MainBookPage(userEmail: user.emailAddress);
        },
      ));

      setState(() {
        isLoggedIn = true;
      });
    } else {
      showError(response.error!.message);
    }
  }

  void doUserLogout() async {
    final user = await ParseUser.currentUser() as ParseUser;
    var response = await user.logout();

    if (response.success) {
      showSuccess("User was successfully logout!");
      setState(() {
        isLoggedIn = false;
      });
    } else {
      showError(response.error!.message);
    }
  }
}
