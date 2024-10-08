// ignore_for_file: file_names, prefer_const_constructors

import 'package:ebook/widgets/DogForm.dart';
import 'package:ebook/widgets/userImg.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

var countDogs;

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
  //initState(): This is the first method called when the widget is created but after constructor call.

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
    var profileimg;
    const title = 'Grid List';

    return Scaffold(
        appBar: AppBar(
          title: Text('Dogs Adoption List'),
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: 50,
          height: 50,
          child: FittedBox(
            child: FloatingActionButton(
              child: Icon(
                Icons.add,
              ),
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
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      snap: true,
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        background: UserImgProfile(
                          usermail: widget.usermail,
                        ),
                      ),
                      expandedHeight: MediaQuery.of(context).size.height * 0.30,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                //fetchData(AppConstants.APIBASE_URL);
                                var l = getTodo(widget.usermail);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.blue,
                        height: 20,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20.0),
                                  topRight: const Radius.circular(20.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Column(
                            children: [
                              // //UserImgProfile(
                              //     usermail:
                              //         widget.usermail), //<----------------------------------
                              UserDogList(
                                usermail: widget.usermail,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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

Future<void> updateTodo(usermail) async {
  await Future.delayed(Duration(seconds: 1), () {});
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  queryTodo.whereEqualTo('UserMail', usermail);
}

Future<void> deleteTodo(String id) async {
  await Future.delayed(Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')..objectId = id;
  await todo.delete();
}

Future<List<ParseObject>> getUserImg(usermail) async {
  await Future.delayed(Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('UserImg'));
  queryTodo.whereEqualTo('emailUser', usermail);
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}
