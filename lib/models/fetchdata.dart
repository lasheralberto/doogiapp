// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:ebook/models/dogsmodel.dart';
import 'package:ebook/models/urldogmodel.dart';
import 'package:http/http.dart' as http;


List<dynamic> BreedList = [];
List<dynamic> BreedUrlList = [];
List<dynamic> glossarList = [];

fetchData(url) async {
  var client = http.Client();
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonDecoded = json.decode(response.body);
    BreedList = jsonDecoded.map((data) => DogClass.fromJson(data)).toList();
    glossarList = BreedList;
    return BreedList;
  } else {
    throw Exception('Failed to load data');
  }
}

fetchDataDogApi(url) async {
  var client = http.Client();
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonDecoded = json.decode(response.body);
    BreedUrlList = jsonDecoded.map((data) => DogUrl.fromJson(data)).toList();
    return jsonDecoded;
  } else {
    throw Exception('Failed to load data');
  }
}

runFilter(String enteredKeyword) {
  List<dynamic> results = [];
  if (enteredKeyword.isEmpty) {
    // if the search field is empty or only contains white-space, we'll display all users
    results = BreedList;
  } else {
    results = BreedList.where((dog) =>
            dog["breed"].toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
    // we use the toLowerCase() method to make it case-insensitive
  }
  return results;
}

