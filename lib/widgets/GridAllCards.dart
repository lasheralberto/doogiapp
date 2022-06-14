import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridAllCards extends StatelessWidget {
  var title;
  var image;
  var gender;
  var city;
  var country;

  GridAllCards(
      {Key? key,
      required this.image,
      required this.title,
      required this.gender,
      this.city,
      this.country})
      : super(key: key);

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            elevation: 6,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 60, right: 5, left: 5, top: 5), //bordes interiores
              child: Stack(children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image as String), //varImg.url
                          fit: BoxFit.cover)),
                  //child:
                ),
              ]),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  IconTheme(
                      data: IconThemeData(
                          color: gender == 'Male' ? Colors.blue : Colors.pink),
                      child: Icon(gender == 'Male'
                          ? Icons.male_rounded
                          : Icons.female_rounded)),
                  Positioned(
                    top: 10,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconTheme(
                      data: IconThemeData(size: 15, color: Colors.red),
                      child: Icon(Icons.location_on)),
                  Positioned(
                    top: 10,
                    child: Text(
                      city,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridAllCardsShimmer extends StatelessWidget {
  GridAllCardsShimmer({
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
            elevation: 6,
            margin: const EdgeInsets.all(8),
            child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 60, right: 5, left: 5, top: 5), //bordes interiores
                child: Stack(children: [
                  Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://ik.imagekit.io/aml28/Google_Contacts_icon.svg_O1-1-E_wH.png?ik-sdk-version=javascript-1.4.3&updatedAt=1654901242362')),
                      )),
                  //child:
                ]))),
        Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Positioned(
                    top: 10,
                    child: Text(
                      'Loading',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  IconTheme(
                      data: IconThemeData(size: 15, color: Colors.red),
                      child: Icon(Icons.location_on)),
                  Positioned(
                    top: 10,
                    child: Text(
                      '',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
