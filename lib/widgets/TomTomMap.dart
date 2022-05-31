import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:latlong2/latlong.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class TomTomMap extends StatelessWidget {
  var lat;
  var long;
  TomTomMap({Key? key, required this.lat, required this.long})
      : super(key: key);

  final String TOMTOM_APIKEY = "e1DSA4HTcC8EAbME3OYAAWwO2FpHEPzW";

  @override
  Widget build(BuildContext context) {
    final LatLng tomtomCenter = LatLng(lat, long);
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
        appBar: AppBar(title: Text('Dogs map')),
        body: Center(
            child: Stack(
          children: <Widget>[
            FlutterMap(
              options: MapOptions(center: tomtomCenter, zoom: 1.0),
              layers: [
                TileLayerOptions(
                  minNativeZoom: 1.0,
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  attributionBuilder: (_) {
                    return Text("© OpenStreetMap contributors");
                  },
                  additionalOptions: {"apiKey": TOMTOM_APIKEY},
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: tomtomCenter,
                      builder: (ctx) => Container(
                        child: Icon(Icons.local_activity_rounded),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}

Future<List<ParseObject>> getAllDogsLocation() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  queryTodo.includeObject(['latitude', 'longitude']);
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}
