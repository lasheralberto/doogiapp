// ignore_for_file: file_names, camel_case_types

import 'package:ebook/widgets/TomTomMap.dart';
import 'package:ebook/widgets/longPressGrid.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class gridListDogs extends StatelessWidget {
  var lat;
  var long;
  gridListDogs({Key? key, required this.lat, required this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return Scaffold(
      floatingActionButton: ElevatedButton(
        child: Wrap(
          children: const <Widget>[
            Icon(
              Icons.map,
              color: Colors.pink,
              size: 24.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Mapa", style: TextStyle(fontSize: 20)),
          ],
        ),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TomTomMap(lat: lat, long: long),
              ));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('Adopt'),
      ),
      body: FutureBuilder<List<ParseObject>>(
          future: getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator()),
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
                  return GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      //*************************************
                      //Get Parse Object Values
                      final varTodo = snapshot.data![index];
                      final varTitle = varTodo.get<String>('title')!;
                      final varBreed = varTodo.get<String>('Breed');
                      final varAge = varTodo.get<String>('Age');
                      final varImg = varTodo.get<ParseFileBase>('DogImg')!;

                      //*************************************
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: Card(
                                    shadowColor: Colors.blue,
                                    elevation: 16,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80)),
                                    child: SafeArea(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const SizedBox(height: 20),
                                          Center(child: Text('$varTitle')),
                                          const SizedBox(height: 20),
                                          Center(
                                              child: Text(
                                            'Age: $varAge ',
                                            textAlign: TextAlign.center,
                                          )),
                                          const SizedBox(height: 20),
                                          const ListTile(
                                            leading: Icon(Icons.message),
                                            title: Text('Messages'),
                                          ),
                                          const ListTile(
                                            leading: Icon(Icons.description),
                                            title: Text('Description'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });

                          //LongPressGridCard(index: index, Age: varAge);
                        },
                        child: Card(
                            elevation: 6,
                            margin: const EdgeInsets.all(12),
                            child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                    width: double.infinity,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                varImg.url as String),
                                            fit: BoxFit.cover)),
                                    child: Container(
                                        alignment: Alignment.bottomRight,
                                        padding: const EdgeInsets.all(12),
                                        child: Text(varTitle,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70)))))),
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 0.0,
                      mainAxisSpacing: 5,
                      mainAxisExtent: 264,
                    ),
                  );
                }
            }
          }),
    );
  }
}

Future<List<ParseObject>> getAllDogs() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}

Future<void> updateTodo(String id, bool done) async {
  await Future.delayed(const Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')
    ..objectId = id
    ..set('done', done);
  await todo.save();
}

Future<void> deleteTodo(String id) async {
  await Future.delayed(const Duration(seconds: 1), () {});
  var todo = ParseObject('Todo')..objectId = id;
  await todo.delete();
}
