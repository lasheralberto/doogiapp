import 'package:ebook/models/fetchdata.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:http/http.dart" as http;
//import 'package:latlong/latlong.dart';
import "dart:convert" as convert;
import 'package:latlong2/latlong.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

List<dynamic> listaLocs  = []  ;

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
  Future<List<dynamic>>? futureLocs;
 
  // ADD THIS

  @override
  void initState() {
    super.initState();
    futureLocs = getAllDogsLocation()   ;
 
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
            FutureBuilder (
                future : futureLocs ,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text("Error loading data..."),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text("No Data..."),
                        );
                      } else {
                        return FlutterMap(
                          
                          options: 
                          MapOptions(
                            //center: tomtomCenter, 
                            zoom: 1.0),
                          layers: [
                            TileLayerOptions(
                              minNativeZoom: 10.0,
                              backgroundColor: Colors.transparent,
                              urlTemplate:
                                  "https://api.tomtom.com/map/1/tile/basic/main/"
                                  "{z}/{x}/{y}.png?key={apiKey}",
                              attributionBuilder: (_) {
                                return Text("© OpenStreetMap contributors");
                              },
                              additionalOptions: {"apiKey": TOMTOM_APIKEY},
                            ),
                            MarkerLayerOptions(
                              markers: [
                                //_buildMarker( tomtomCenter, 'tomtomCenter'),
                                for (var mark in snapshot.data)
                                //{
                                _buildMarker(LatLng(mark['latitude'], mark['longitude']), 'Others', mark['DogImg'].url.toString())
                                //}
                              ],
                            ),
                          ],
                        );
                      }
                  }
                })
          ],
        )),
      ),
    );
  }
}
 


Marker _buildMarker(LatLng latLng, String currentLocation, String dogimg) {
  return Marker(
    point: latLng,
    width: 10.0,
    height: 10.0,
    //anchorPos: AnchorPos.exactly(Anchor(2, 2)),
    builder: (BuildContext context) => 
    CircleAvatar(backgroundImage: NetworkImage(dogimg),)
 
  );
}
