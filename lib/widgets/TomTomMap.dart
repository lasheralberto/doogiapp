import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:latlong2/latlong.dart';

class TomTomMap extends StatelessWidget {
  var lat;
  var long;
  TomTomMap({Key? key, required this.lat, required this.long})
      : super(key: key);

  final String TOMTOM_APIKEY = "e1DSA4HTcC8EAbME3OYAAWwO2FpHEPzW";

  @override
  Widget build(BuildContext context) {
    final LatLng tomtomHQ = LatLng(lat, long);
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: tomtomHQ, zoom: 9.0),
              layers: [
                new TileLayerOptions(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": TOMTOM_APIKEY},
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
