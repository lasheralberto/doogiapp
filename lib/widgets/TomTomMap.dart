import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/personalDogDetail.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
//import 'package:latlong/latlong.dart';
import 'package:latlong2/latlong.dart';

List<dynamic> listaLocs = [];

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
  late double currentZoom = 16.0;

  @override
  void initState() {
    super.initState();

    futureLocs = getAllDogsLocation();
  }

  final String TOMTOM_APIKEY = AppConstants.tomtomKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TomTom Map",
      home: Scaffold(
          appBar: AppBar(title: const Text('Dogs map')),
          body: Center(
              child: Stack(
            children: <Widget>[
              FutureBuilder(
                  future: futureLocs,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
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
                            mapController: mapController,
                            options: MapOptions(
                                center: LatLng(widget.lat, widget.long),
                                zoom: currentZoom),
                            layers: [
                              TileLayerOptions(
                                minNativeZoom: 1.0,
                                backgroundColor: Colors.transparent,
                                urlTemplate:
                                    "https://api.tomtom.com/map/1/tile/basic/main/"
                                    "{z}/{x}/{y}.png?key={apiKey}",
                                attributionBuilder: (_) {
                                  return const Text(
                                      "© OpenStreetMap contributors");
                                },
                                additionalOptions: {"apiKey": TOMTOM_APIKEY},
                              ),
                              MarkerLayerOptions(
                                markers: [
                                  //_buildMarker( tomtomCenter, 'tomtomCenter'),
                                  for (var mark in snapshot.data)
                                    //{
                                    _buildMarker(
                                      LatLng(
                                          mark['latitude'], mark['longitude']),
                                      mark['DogImg'].url.toString(),
                                      mark['DogDescription'],
                                      mark['title'],
                                      mark['Age'],
                                      'All'
                                    )
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
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: Text('CurrentLoc'),
                onPressed: () {
                  setState(() {
                    mapController.move(
                        LatLng(widget.lat, widget.long), currentZoom);
                  });
                },
                tooltip: 'Current location',
                child: const Icon(Icons.location_history),
              ),
              FloatingActionButton(
                heroTag: Text('zoomin'),
                onPressed: () {
                  setState(() {
                    currentZoom = currentZoom + 1;
                    mapController.move(
                        LatLng(widget.lat, widget.long), currentZoom);
                  });
                },
                tooltip: 'Zoom in',
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                heroTag: Text('zoomout'),
                onPressed: () {
                  setState(() {
                    currentZoom = currentZoom - 1;
                    mapController.move(
                        LatLng(widget.lat, widget.long), currentZoom);
                  });
                },
                tooltip: 'Zoom out',
                child: const Icon(Icons.remove_circle_outline_rounded),
              ),
            ],
          )),
    );
  }
}

Marker _buildMarker(LatLng latLng, String dogimg, String dogDesc, String dogname, String dogAge,
    String screen) {

  return Marker(
      point: latLng,
      builder: (BuildContext context) => GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => personalDogDetail(
                          title: dogname, 
                          Age: dogAge,
                          img : dogimg,
                          description: dogDesc,

                          screen: screen)));
            },
            child: Container(
              width: 190.0,
              height: 190.0,
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 4, color: Colors.blue),

              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.network(
                  dogimg,
                  height: 190.0,
                  width: 190.0,
                ),
              ),
            ),
          ));
}
