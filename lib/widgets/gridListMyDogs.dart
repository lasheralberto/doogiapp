// ignore_for_file: file_names, camel_case_types

import 'package:ebook/models/fetchdata.dart';
import 'package:ebook/widgets/DogForm.dart';
import 'package:ebook/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class gridListDogs extends StatelessWidget {

  const gridListDogs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';

    return Scaffold(
      appBar: AppBar(title: Text('Adopt'),),
      body: FutureBuilder<List<ParseObject>>(
          future: getAllDogs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                        final varImg = varTodo.get<ParseFileBase>('DogImg')!;
                        

                        //*************************************
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
                                            image: NetworkImage(varImg.url as String),
                                            fit: BoxFit.cover)),
                                    child: Container(
                                        alignment: Alignment.bottomRight,
                                        padding: const EdgeInsets.all(12),
                                        child: Text(varTitle ,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white70))))));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 264,
                      ));
                }
            }
          }),
    );
  }
}

Future<List<ParseObject>> getAllDogs() async {
  await Future.delayed(Duration(seconds: 2), () {});
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
