// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/widgets/DogForm.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class DogsAdoptionList extends StatefulWidget {
  var lat;
  var long;
  var usermail;

  DogsAdoptionList({
    Key? key,
    required this.lat,
    required this.long,
    required this.usermail,
  }) : super(key: key);

  @override
  State<DogsAdoptionList> createState() => _DogsAdoptionListState();
}

class _DogsAdoptionListState extends State<DogsAdoptionList> {
  var city;
  var country;
  Future<void> GetAddressFromLatLong(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String? cityname = place.administrativeArea;
    String? countryName = place.country;
    //'${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      city = cityname;
      country = countryName;
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return Scaffold(
      appBar: AppBar(
        title: Text('My dogs for adoption'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          GetAddressFromLatLong(widget.lat, widget.long);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DogForm(
                  lat: widget.lat,
                  long: widget.long,
                  city: city,
                  country: country,
                ),
              ));
        },
      ),
      body: FutureBuilder<List<ParseObject>>(
        future: getTodo(widget.usermail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: const CircularProgressIndicator()),
              );
            default:
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error..."),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Data..."),
                );
              } else {
                return ListView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //*************************************
                      //Get Parse Object Values
                      final varTodo = snapshot.data![index];
                      final varTitle = varTodo.get<String>('title')!;
                      final varBreed = varTodo.get<String>('Breed');
                      final varImg = varTodo.get<ParseFileBase>('DogImg')!;

                      //*************************************

                      return ListTile(
                        title: Text(varTitle),
                        subtitle: Text(varBreed as String),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          child: Image.network(varImg.url as String),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            // IconButton(
                            //   icon: const Icon(
                            //     Icons.delete_outline,
                            //     color: Colors.blue,
                            //   ),
                            //   onPressed: () async {
                            //     await deleteTodo(varTodo.objectId!);
                            //     setState(() {
                            //       final snackBar = SnackBar(
                            //         content: Text("Todo deleted!"),
                            //         duration: Duration(seconds: 1),
                            //       );
                            //       ScaffoldMessenger.of(context)
                            //         ..removeCurrentSnackBar()
                            //         ..showSnackBar(snackBar);
                            //     });
                            //   },
                            // )
                          ],
                        ),
                      );
                    });
              }
          }
        },
      ),
    );
  }
}

Future<List<ParseObject>> getTodo(usermail) async {
  await Future.delayed(Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  queryTodo.whereEqualTo('UserMail', usermail);
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}

Future<void> updateTodo(String id, bool done) async {
  await Future.delayed(Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')
    ..objectId = id
    ..set('done', done);
  await todo.save();
}

Future<void> deleteTodo(String id) async {
  await Future.delayed(Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')..objectId = id;
  await todo.delete();
}
