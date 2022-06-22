import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:ebook/widgets/personalDogDetail.dart';
import 'package:ebook/widgets/small_text.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
//import 'package:latlong/latlong.dart';
//import 'package:latlong/latlong.dart';
import 'package:latlong2/latlong.dart';

List<dynamic> listaLocs = [];

class TomTomMap extends StatefulWidget {
  var lat;
  var long;
  var screen;

  TomTomMap({Key? key, required this.lat, required this.long, this.screen})
      : super(key: key);

  @override
  State<TomTomMap> createState() => _TomTomMapState();
}

class _TomTomMapState extends State<TomTomMap> {
  MapController mapController = MapController();
  PageController pageController = PageController();
  Future<List<dynamic>>? futureLocs;
  late double currentZoom = 16.0;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7, initialPage: _index);

    //mapController.move(LatLng(10.0, 10.0), 16.0);

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
                          return Stack(
                            children: [
                              FlutterMap(
                                mapController: mapController,
                                options: MapOptions(
                                    center: LatLng(widget.lat, widget.long),
                                    zoom: currentZoom),
                                layers: [
                                  TileLayerOptions(
                                    minNativeZoom: 1.0,
                                    backgroundColor: Colors.transparent,
                                    urlTemplate:
                                        "https://api.tomtom.com/map/1/tile/basic/night/"
                                        "{z}/{x}/{y}.png?key={apiKey}",
                                    //https://developer.tomtom.com/map-display-api/documentation/mapstyles/map-styles#available-map-styles

                                    attributionBuilder: (_) {
                                      return const Text(
                                          "© OpenStreetMap contributors");
                                    },
                                    additionalOptions: {
                                      "apiKey": TOMTOM_APIKEY
                                    },
                                  ),
                                  MarkerLayerOptions(
                                    markers: [
                                      //_buildMarker( tomtomCenter, 'tomtomCenter'),
                                      for (var mark in snapshot.data)
                                        //{
                                        _buildMarker(
                                          LatLng(mark['latitude'],
                                              mark['longitude']),
                                          mark['DogImg'].url.toString(),
                                          mark['DogDescription'],
                                          mark['title'],
                                          mark['Age'],
                                          'All',
                                          widget.lat,
                                          widget.long,
                                        )
                                      //}
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 150,
                                child: widget.screen == 'All'
                                    ? Divider()
                                    : widget.screen == 'personal_detailForm'
                                        ? Divider()
                                        : PageView.builder(
                                            itemCount: dogInMapCount,
                                            controller: pageController,
                                            onPageChanged: (int index) =>
                                                setState(() {
                                              _index = index;
                                              widget.screen ==
                                                      'personal_detailForm'
                                                  ? mapController.move(
                                                      LatLng(widget.lat,
                                                          widget.long),
                                                      currentZoom)
                                                  : mapController.move(
                                                      LatLng(
                                                          snapshot.data[index]
                                                              ['latitude'],
                                                          snapshot.data[index]
                                                              ['longitude']),
                                                      currentZoom);
                                            }),
                                            itemBuilder: (_, i) {
                                              return Transform.scale(
                                                scale: i == _index ? 1 : 0.9,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                personalDogDetail(
                                                                  title: snapshot
                                                                          .data[i]
                                                                      ['title'],
                                                                  Age: snapshot
                                                                          .data[
                                                                      i]['Age'],
                                                                  img: snapshot
                                                                      .data[i][
                                                                          'DogImg']
                                                                      .url,
                                                                  description:
                                                                      snapshot.data[
                                                                              i]
                                                                          [
                                                                          'DogDescription'],
                                                                  screen: 'All',
                                                                  lat: snapshot
                                                                          .data[i]
                                                                      [
                                                                      'latitude'],
                                                                  long: snapshot
                                                                          .data[i]
                                                                      [
                                                                      'longitude'],
                                                                )));
                                                  },
                                                  child: Card(
                                                    elevation: 6,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 30,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    snapshot
                                                                        .data[i]
                                                                            [
                                                                            'DogImg']
                                                                        .url),
                                                          ),
                                                          ListTile(
                                                            title: Center(
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data[
                                                                            i][
                                                                        'title'],
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            32),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  IconTheme(
                                                                      data: IconThemeData(
                                                                          color: snapshot.data[i]['Gender'] == 'Male'
                                                                              ? Colors
                                                                                  .blue
                                                                              : Colors
                                                                                  .pink),
                                                                      child: Icon(snapshot.data[i]['Gender'] ==
                                                                              'Male'
                                                                          ? Icons
                                                                              .male
                                                                          : Icons
                                                                              .female))
                                                                ],
                                                              ),
                                                            ),
                                                            subtitle: Center(
                                                                child: Text(snapshot
                                                                        .data[i]
                                                                    ['Breed'])),
                                                          ),
                                                          SmallText(
                                                              text: snapshot
                                                                          .data[i]
                                                                      [
                                                                      'CityName'] +
                                                                  ' , ' +
                                                                  snapshot.data[
                                                                          i][
                                                                      'CountryName'])
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                              ),
                            ],
                          );
                        }
                    }
                  }),
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
              // FloatingActionButton(
              //   heroTag: Text('zoomin'),
              //   onPressed: () {
              //     setState(() {
              //       currentZoom = currentZoom + 1;
              //       mapController.move(
              //           LatLng(widget.lat, widget.long), currentZoom);
              //     });
              //   },
              //   tooltip: 'Zoom in',
              //   child: const Icon(Icons.add),
              // ),
              // FloatingActionButton(
              //   heroTag: Text('zoomout'),
              //   onPressed: () {
              //     setState(() {
              //       currentZoom = currentZoom - 1;
              //       mapController.move(
              //           LatLng(widget.lat, widget.long), currentZoom);
              //     });
              //   },
              //   tooltip: 'Zoom out',
              //   child: const Icon(Icons.remove_circle_outline_rounded),
              // ),
            ],
          )),
    );
  }
}

Marker _buildMarker(
    LatLng latLng,
    String dogimg,
    String dogDesc,
    String dogname,
    String dogAge,
    String screen,
    double paramlat,
    double paramlong) {
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
                            img: dogimg,
                            description: dogDesc,
                            screen: screen,
                            lat: paramlat,
                            long: paramlong,
                          )));
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
