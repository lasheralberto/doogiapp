// To parse this JSON data, do
//
//     final back4App = back4AppFromJson(jsonString);

import 'dart:convert';

class Back4App {
    Back4App({
        required this.results,
    });

    List<Result> results;

    factory Back4App.fromRawJson(String str) => Back4App.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Back4App.fromJson(Map<String, dynamic> json) => Back4App(
        results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    Result({
        required this.objectId,
        required this.userId,
        required this.userMail,
        required this.title,
        required this.age,
        required this.dogImg,
        required this.createdAt,
        required this.updatedAt,
        required this.breed,
        required this.latitude,
        required this.longitude,
        required this.dogDescription,
        required this.gender,
        required this.cityName,
        required this.countryName,
        required this.concatId,
    });

    String objectId;
    String userId;
    String userMail;
    String title;
    String age;
    DogImg dogImg;
    DateTime createdAt;
    DateTime updatedAt;
    String breed;
    double latitude;
    double longitude;
    String dogDescription;
    String gender;
    String cityName;
    String countryName;
    String concatId;

    factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        objectId: json["objectId"],
        userId: json["UserId"],
        userMail: json["UserMail"],
        title: json["title"],
        age: json["Age"],
        dogImg: DogImg.fromJson(json["DogImg"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        breed: json["Breed"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        dogDescription: json["DogDescription"],
        gender: json["Gender"],
        cityName: json["CityName"],
        countryName: json["CountryName"],
        concatId: json["concatId"],
    );

    Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "UserId": userId,
        "UserMail": userMail,
        "title": title,
        "Age": age,
        "DogImg": dogImg.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "Breed": breed,
        "latitude": latitude,
        "longitude": longitude,
        "DogDescription": dogDescription,
        "Gender": gender,
        "CityName": cityName,
        "CountryName": countryName,
        "concatId": concatId,
    };
}

class DogImg {
    DogImg({
        required this.type,
        required this.name,
        required this.url,
    });

    String type;
    String name;
    String url;

    factory DogImg.fromRawJson(String str) => DogImg.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory DogImg.fromJson(Map<String, dynamic> json) => DogImg(
        type: json["__type"],
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "__type": type,
        "name": name,
        "url": url,
    };
}
