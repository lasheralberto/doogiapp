// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:ebook/models/GridModel.dart';
import 'package:ebook/models/dogsmodel.dart';

import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

List<dynamic> BreedList = [];
List<dynamic> BreedUrlList = [];
List<dynamic> glossarList = [];
List<dynamic> GridAllDogsList = [];
List<dynamic> allDogsInMap = [];
var dogInMapCount;

Future<List<dynamic>> fetchData(url) async {
  var client = http.Client();
  final response = await client.get(Uri.parse(url));
  await Future.delayed(const Duration(seconds: 2));
  if (response.statusCode == 200) {
    var jsonDecoded = json.decode(response.body);
    BreedList = jsonDecoded.map((data) => DogClass.fromJson(data)).toList();
    glossarList = BreedList;
    return BreedList;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<dynamic>> fetchDataFor(url) async {
  var client = http.Client();
  final response = await client.get(Uri.parse(url));
  await Future.delayed(const Duration(seconds: 2));
  if (response.statusCode == 200) {
    var jsonDecoded = json.decode(response.body);
    BreedList = [for (var data in jsonDecoded) DogClass.fromJson(data)];
    return BreedList;
  } else {
    throw Exception('Failed to load data');
  }
}

fetchDataParam(url, param) async {
  var client = http.Client();
  final response = await client.get(Uri.parse(url));
  await Future.delayed(const Duration(seconds: 2));
  if (response.statusCode == 200) {
    var jsonDecoded = json.decode(response.body);
    BreedList = jsonDecoded.map((data) => DogClass.fromJson(data)).toList();

    return BreedList.where(
        (dog) => dog.breed.toLowerCase().contains(param.toLowerCase()));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<dynamic>> getAllDogsLocation() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  // queryTodo.includeObject(['latitude']);
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    dogInMapCount = apiResponse.results!.length;

    return apiResponse.results as List<ParseObject>;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<ParseObject>> getAllDogs() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  final ParseResponse apiResponse = await queryTodo.query();

  if (apiResponse.success && apiResponse.results != null) {
    //GridAllDogsList = [for (var data in apiResponse.results!) Result.fromJson(data)];
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}


Future<List<dynamic>> getAllDogs2() async {
  await Future.delayed(const Duration(seconds: 2), () {});
  QueryBuilder<ParseObject> queryTodo =
      QueryBuilder<ParseObject>(ParseObject('Todo'));
  final ParseResponse apiResponse = await queryTodo.query();
  var jsonResults = apiResponse.results;

  if (apiResponse.success && apiResponse.results != null) {
    //GridAllDogsList = jsonResults!;
    //return apiResponse.results as List<ParseObject>;
    //return GridAllDogsList;
    GridAllDogsList = [for (var data in jsonResults!) Result.fromJson(data)];
    return GridAllDogsList;
  } else {
    return [];
  }
}
