import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebook/pages/home/main_book_page.dart';
import 'package:ebook/widgets/Login.dart';
import 'package:ebook/widgets/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

//https://www.youtube.com/watch?v=7dAt-JMSCVQ
//https://www.back4app.com/docs/flutter/parse-sdk/users/flutter-login

Future<void> main() async {
  //this will make sure the dep are loaded correctly
  CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'USNwyNAtrpDSief7vHRuXJUZ8cVQQjZQ3i5an5pK';
  final keyClientKey = '23fX637JXhjdB8cDGMPxu82dzzrKFeJDcYuZbUxp';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
          Directionality(textDirection: TextDirection.ltr, child: LoginPage()),
      //PopularBookDetails
    );
  }
}
