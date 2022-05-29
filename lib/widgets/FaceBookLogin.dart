import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class FaceBookLogin extends StatelessWidget {
  
  Future<bool> hasUserLogged() async {
    ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;
    if (currentUser == null) {
      return false;
    }
    //Checks whether the user's session token is valid
    final ParseResponse? parseResponse =
        await ParseUser.getCurrentUserFromServer(currentUser.sessionToken!);

    if (parseResponse?.success == null || !parseResponse!.success) {
      //Invalid session. Logout
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter - Sign In with Facebook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Scaffold(
                  body: Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
              default:
                if (snapshot.hasData && snapshot.data!) {
                  return UserPage();
                } else {
                  return HomeFaceBookPage();
                }
            }
          }),
    );
  }
}

class HomeFaceBookPage extends StatefulWidget {
  @override
  _HomeFaceBookPageState createState() => _HomeFaceBookPageState();
}

class _HomeFaceBookPageState extends State<HomeFaceBookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter - Sign In with Facebook'),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.network(
                      'http://blog.back4app.com/wp-content/uploads/2017/11/logo-b4a-1-768x175-1.png'),
                ),
                const Center(
                  child: Text('Flutter on Back4App',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    child: const Text('Sign In with Facebook'),
                    onPressed: () => doSignInFacebook(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ));
  }

  void doSignInFacebook() async {
    late ParseResponse parseResponse;
    try {
      //Check if the user is logged.
      final AccessToken? currentAccessToken =
          await FacebookAuth.instance.accessToken;
      if (currentAccessToken != null) {
        //Logout
        await FacebookAuth.instance.logOut();
      }

      //Make a Login request
      final LoginResult result = await FacebookAuth.instance.login();

      if (result.status != LoginStatus.success) {
        Message.showError(context: context, message: result.message!);
        return;
      }

      final AccessToken accessToken = result.accessToken!;

      //https://docs.parseplatform.org/parse-server/guide/#facebook-authdata
      //According to the documentation, we must send a Map with user authentication data.

      //Make sign in with Facebook
      parseResponse = await ParseUser.loginWith('facebook',
          facebook(accessToken.token, accessToken.userId, accessToken.expires));

      if (parseResponse.success) {
        final ParseUser parseUser = await ParseUser.currentUser() as ParseUser;

        //Get user data from Facebook
        final userData = await FacebookAuth.instance.getUserData();

        //Additional Information in User
        if (userData.containsKey('email')) {
          parseUser.emailAddress = userData['email'];
        }

        if (userData.containsKey('name')) {
          parseUser.set<String>('name', userData['name']);
        }
        if (userData["picture"]["data"]["url"] != null) {
          parseUser.set<String>('photoURL', userData["picture"]["data"]["url"]);
        }

        await FacebookAuth.instance.logOut();
        parseResponse = await parseUser.save();

        if (parseResponse.success) {
          Message.showSuccess(
              context: context,
              message: 'User was successfully with Sign In Facebook!',
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                  (Route<dynamic> route) => false,
                );
              });
        } else {
          Message.showError(
              context: context, message: parseResponse.error!.message);
        }
      } else {
        Message.showError(
            context: context, message: parseResponse.error!.message);
      }
    } on Exception catch (e) {
      print(e.toString());
      Message.showError(context: context, message: e.toString());
    }
  }
}

class UserPage extends StatelessWidget {
  Future<ParseUser?> getUser() async {
    return await ParseUser.currentUser() as ParseUser?;
  }

  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      final currentUser = await ParseUser.currentUser() as ParseUser;
      var response = await currentUser.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'User was successfully logout!',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeFaceBookPage()),
                (Route<dynamic> route) => false,
              );
            });
      } else {
        Message.showError(context: context, message: response.error!.message);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter - Sign In with Facebook'),
        ),
        body: FutureBuilder<ParseUser?>(
            future: getUser(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                                'Hello, ${snapshot.data!.get<String>('name')}')),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            child: const Text('Logout'),
                            onPressed: () => doUserLogout(),
                          ),
                        ),
                      ],
                    ),
                  );
              }
            }));
  }
}

class Message {
  static void showSuccess(
      {required BuildContext context,
      required String message,
      VoidCallback? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static void showError(
      {required BuildContext context,
      required String message,
      VoidCallback? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (onPressed != null) {
                  onPressed();
                }
              },
            ),
          ],
        );
      },
    );
  }
}