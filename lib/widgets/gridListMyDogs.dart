// ignore_for_file: file_names, camel_case_types

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/DogForm.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:flutter/material.dart';

class gridListDogs extends StatelessWidget {
  var lat;
  var long;
  gridListDogs({Key? key, this.lat, this.long}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return FutureBuilder(
        future: fetchData(AppConstants.APIBASE_URL),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DogForm(lat: lat, long: long)),
                );
              },
            ),
            body: GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                itemCount: BreedList.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 6,
                      margin: const EdgeInsets.all(12),
                      child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                              width: double.infinity,
                              height: 10,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(BreedList[index]
                                          .urls2[0]
                                          .urlBreed[1]),
                                      fit: BoxFit.cover)),
                              child: Container(
                                  alignment: Alignment.bottomRight,
                                  padding: const EdgeInsets.all(12),
                                  child: Text(BreedList[index].breed,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white70))))));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 264,
                )),
          );
        });
  }
}
