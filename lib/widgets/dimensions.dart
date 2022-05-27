import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / 2.64;
  static double pageViewContainer = screenHeight / 3.84;
  static double pageViewTextContainer = screenHeight / 7.03;

  //for sizedboxes
  static double height10 = screenHeight / 84.4;
  static double height20 = screenHeight / 42.2;

  static double font16 = screenHeight / 52.75;
  static double font20 = screenHeight / 42.2;
  static double font26 = screenHeight / 32.6;

  static double width10 = screenWidth / 84.4;
  static double width20 = screenWidth / 42.2;

  static double bottomHeightBar = screenHeight / 7.03;

  //for radius
  static double radius20 = screenHeight / 42.2;
  static double radius30 = screenHeight / 28.13;

  //list view
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextContSize = screenWidth / 3.9;

  //for details
  static double popularBookIMGSize = screenHeight / 3.0;
  static double iconSize24 = screenHeight / 35.17;
  static double iconSize16 = screenHeight / 52.75;
}
