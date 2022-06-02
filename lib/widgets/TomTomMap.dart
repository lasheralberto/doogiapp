import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:latlong2/latlong.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

List<ParseObject> listaLocs = [];

class TomTomMap extends StatefulWidget {
  var lat;
  var long;

  TomTomMap({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  State<TomTomMap> createState() => _TomTomMapState();
}

class _TomTomMapState extends State<TomTomMap> {
  MapController mapController = MapController();
  late Future<QueryBuilder<ParseObject>> markers;
  // ADD THIS

  @override
  void initState() {
    super.initState();
    startAsyncInit();
  }

  Future startAsyncInit() async {
    setState(() {
      markers = getAllDogsLocation();
      ;
    });
  }

  final String TOMTOM_APIKEY = "e1DSA4HTcC8EAbME3OYAAWwO2FpHEPzW";

  @override
  Widget build(BuildContext context) {
    //Future<QueryBuilder<ParseObject>> DogsLocation = getAllDogsLocation();
    final LatLng tomtomCenter = LatLng(widget.lat, widget.long);
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
                    // for (var mark in markers)
                      //{
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: tomtomCenter,
                          builder: (ctx) => Container(
                            child: Icon(Icons.local_activity_rounded),
                          ),
                        ),
                      //}
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

Future<QueryBuilder<ParseObject>> getAllDogsLocation() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  queryTodo.includeObject(['latitude']);
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    // for (var point in apiResponse.results as List<ParseObject>) {
    //   listaLocs.add(point);
    // }
    return queryTodo;
  } else {
    throw Exception('Failed to load data');
  }
}
