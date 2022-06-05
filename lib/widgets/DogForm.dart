// ignore: file_names
// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../models/genderFormModel.dart';

class DogForm extends StatefulWidget {
  var lat;
  var long;
  var city;

  DogForm({Key? key, required this.lat, required this.long, this.city})
      : super(key: key);
  //final double lat;
  //final double long;
  @override
  _DogFormState createState() => _DogFormState();
}

class _DogFormState extends State<DogForm> {
  final DogsNameController = TextEditingController();
  final DogsAgeController = TextEditingController();
  final DogsDescriptionController = TextEditingController();
  final DogsGenderController = TextEditingController();


  PickedFile? pickedFile;
  bool isLoading = false;
  late ParseFileBase parseFile;
  final List<DropdownMenuItem> breeds = [];

  String? _mySelection = 'Cavalier King Charles Spaniel';
  String? _mySelectionGender = 'Male';

  @override
  void initState() {
    super.initState();
  }

  void addToDo(
      String controllername,
      String controllerage,
      String breedSelection,
      double lat,
      double long,
      ParseFileBase parsefile,
      String dogdesc,
      String Gender) async {
    if (controllername.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Empty Name"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    if (controllerage.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Empty Age"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveTodo(controllername, controllerage, lat, long, breedSelection,
        parsefile, dogdesc);

    setState(() {
      DogsNameController.clear();
      DogsAgeController.clear();
      DogsDescriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption Form"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: DogsNameController,
                        decoration: InputDecoration(
                            labelText: "Dog's Name",
                            labelStyle: TextStyle(color: Colors.blueAccent)),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: DogsAgeController,
                        decoration: InputDecoration(
                            labelText: "Dog's Age",
                            labelStyle: TextStyle(color: Colors.blueAccent)),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        minLines: 5,
                        maxLines: null,
                        autocorrect: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: DogsDescriptionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            labelText: "Dog's Description",
                            labelStyle: TextStyle(
                              color: Colors.blueAccent,
                            )),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: const Text('Select Breed'),
                            value: _mySelection,
                            onChanged: (String? newValue) {
                              setState(() {
                                _mySelection = newValue;
                              });
                            },
                            items: _mybreedList.map((Map map) {
                              return DropdownMenuItem<String>(
                                value: map["breed"],
                                // value: _mySelection,
                                child: Row(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      child: Image.network(
                                        map["img"],
                                        width: 25,
                                      ),
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(map["breed"])),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            isDense: true,
                            hint: const Text('Select Gender'),
                            value: _mySelectionGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                _mySelectionGender = newValue;
                              });
                            },
                            items: _genderOpts.map((Map map) {
                              return DropdownMenuItem<String>(
                                value: map["gender"],
                                // value: _mySelection,
                                child: Row(
                                  children: <Widget>[
                                    IconTheme(
                                        data: IconThemeData(
                                            color: _mySelectionGender == 'Male'
                                                ? Colors.blue
                                                : Colors.pink),
                                        child: Icon(_mySelectionGender == 'Male'
                                            ? Icons.male
                                            : Icons.female)),
                                    Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Text(map["gender"])),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),

            Text(widget.city.toString()),
            //Text('LNG: ${widget.long}'),

            ///Text('ADDRESS: ${_currentAddress ?? "na"}'),
            const SizedBox(height: 32),
            GestureDetector(
              child: pickedFile != null
                  ? Container(
                      width: 250,
                      height: 250,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.blue)),
                      child: Image.file(File(pickedFile!.path)))
                  : Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 4),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: Text('Click here to pick image from Gallery'),
                      ),
                    ),
              onTap: () async {
                PickedFile? image =
                    await ImagePicker().getImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    pickedFile = image;
                  });
                }
              },
            ),
            SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  //Flutter Mobile/Desktop
                  parseFile = ParseFile(File(pickedFile!.path));

                  ParseUser? currentUser = await ParseUser.currentUser();
                  await Future.delayed(Duration(seconds: 1), () {});

                  addToDo(
                      DogsNameController.text,
                      DogsAgeController.text,
                      _mySelection as String,
                      widget.lat,
                      widget.long,
                      parseFile,
                      DogsDescriptionController.text,
                      _mySelectionGender as String);

                  setState(() {
                    isLoading = false;
                    pickedFile = null;
                  });

                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'Save file with success on Back4app',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.blue,
                      ),
                    );
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> saveTodo(String title, String DogsAge, double lat, double long,
    String breedselection, ParseFileBase parseFile, String description) async {
  ParseUser? currentUser = await ParseUser.currentUser() as ParseUser?;

  await Future.delayed(Duration(seconds: 1), () {});
  final todo = ParseObject('Todo')
    ..set('UserId', currentUser!.objectId)
    ..set('UserMail', currentUser.emailAddress)
    ..set('Breed', breedselection)
    ..set('title', title)
    ..set('Age', DogsAge)
    ..set('DogImg', parseFile)
    ..set('latitude', lat)
    ..set('longitude', long)
    ..set('DogDescription', description)
    ..set('Gender', Gender)
    ..set('done', false);
  await todo.save();
}

final List<Map> _genderOpts = [
  {'gender': 'Male', 'imgGender': Icons.male},
  {'gender': 'Female', 'imgGender': Icons.female}
];

final List<Map> _mybreedList = [
  {
    "breed": "Cavalier King Charles Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/CarterBIS.Tiki.13.6.09.jpg/220px-CarterBIS.Tiki.13.6.09.jpg"
  },
  {
    "breed": "Curly-Coated Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Curly_Coated_Retriever.jpg/220px-Curly_Coated_Retriever.jpg"
  },
  {
    "breed": "Alaskan Malamute",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Alaskan_Malamute.jpg/300px-Alaskan_Malamute.jpg"
  },
  {
    "breed": "American Staffordshire Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/AMERICAN_STAFFORDSHIRE_TERRIER%2C_Zican%E2%80%99s_Bz_Ez_Dragon_%2824208348891%29.2.jpg/220px-AMERICAN_STAFFORDSHIRE_TERRIER%2C_Zican%E2%80%99s_Bz_Ez_Dragon_%2824208348891%29.2.jpg"
  },
  {
    "breed": "Basset Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/BassetHound_profil.jpg/220px-BassetHound_profil.jpg"
  },
  {
    "breed": "Bohemian Shepherd",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/OREADY_KROSANDRA_%2814%29.JPG/220px-OREADY_KROSANDRA_%2814%29.JPG"
  },
  {
    "breed": "Central Asian Shepherd Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/2.CAO_in_Hungary.jpg/220px-2.CAO_in_Hungary.jpg"
  },
  {
    "breed": "Chihuahua",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Chihuahua1_bvdb.jpg/220px-Chihuahua1_bvdb.jpg"
  },
  {
    "breed": "Airedale Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Airedale_Terrier.jpg/220px-Airedale_Terrier.jpg"
  },
  {
    "breed": "Akita",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/American-akita.jpg/220px-American-akita.jpg"
  },
  {
    "breed": "American Water Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Chien_d%27eau_americain_champion_1.JPG/220px-Chien_d%27eau_americain_champion_1.JPG"
  },
  {
    "breed": "American Hairless Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Aht-sable%26white3.jpg/220px-Aht-sable%26white3.jpg"
  },
  {
    "breed": "Bolognese",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/DocFile_Bolognese.jpg/220px-DocFile_Bolognese.jpg"
  },
  {
    "breed": "Briard",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Briard_fauve.JPG/220px-Briard_fauve.JPG"
  },
  {
    "breed": "Canaan Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/CanaanDogChakede.jpg/220px-CanaanDogChakede.jpg"
  },
  {
    "breed": "Cesky Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Terier_czeski_suka_2009_pl2.jpg/220px-Terier_czeski_suka_2009_pl2.jpg"
  },
  {
    "breed": "Dogue de Bordeaux",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/French_Mastiff_female_4.jpg/220px-French_Mastiff_female_4.jpg"
  },
  {
    "breed": "Hokkaido",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Hokkaidou_inu.jpg/220px-Hokkaidou_inu.jpg"
  },
  {
    "breed": "Appenzeller Sennenhund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Dara_essy.jpg/220px-Dara_essy.jpg"
  },
  {
    "breed": "Australian Kelpie",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Hilu_the_Australian_Kelpie_dog.jpg/220px-Hilu_the_Australian_Kelpie_dog.jpg"
  },
  {
    "breed": "Azawakh",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Bistrita_2015_%2822%29.jpg/220px-Bistrita_2015_%2822%29.jpg"
  },
  {
    "breed": "Bulldog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Bulldog_adult_male.jpg/220px-Bulldog_adult_male.jpg"
  },
  {
    "breed": "French Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/04031137_Epagneul_Francais.jpg/220px-04031137_Epagneul_Francais.jpg"
  },
  {
    "breed": "American Foxhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/AmericanFoxhound2.jpg/220px-AmericanFoxhound2.jpg"
  },
  {
    "breed": "Boerboel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Boerboel_fawn_border.jpg/220px-Boerboel_fawn_border.jpg"
  },
  {
    "breed": "Border Collie",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/BORDER_COLLIE%2C_Simaro_Million_Dollar_Baby_%2824290879465%29_2.jpg/220px-BORDER_COLLIE%2C_Simaro_Million_Dollar_Baby_%2824290879465%29_2.jpg"
  },
  {
    "breed": "Gordon Setter",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Orrvilas_enska_w800px.jpg/220px-Orrvilas_enska_w800px.jpg"
  },
  {
    "breed": "Barbado da Terceira",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Barbado_da_Terceira_%28young_female%29.jpg/220px-Barbado_da_Terceira_%28young_female%29.jpg"
  },
  {
    "breed": "Berger Picard",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Picard_Delice_Stacked.jpg/220px-Picard_Delice_Stacked.jpg"
  },
  {
    "breed": "Border Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Border_Terrier.jpg/220px-Border_Terrier.jpg"
  },
  {
    "breed": "Bull Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Bullterrier-3453301920.jpg/220px-Bullterrier-3453301920.jpg"
  },
  {
    "breed": "Eurasier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Eurasier_BailyWtatze.jpg/220px-Eurasier_BailyWtatze.jpg"
  },
  {
    "breed": "German Shorthaired Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Duitse_staande_korthaar_10-10-2.jpg/220px-Duitse_staande_korthaar_10-10-2.jpg"
  },
  {
    "breed": "Alaskan Klee Kai",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/WOWAKK-Kukai-Alaskan-Klee-Kai.jpg/220px-WOWAKK-Kukai-Alaskan-Klee-Kai.jpg"
  },
  {
    "breed": "Boykin Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Boykin_Spaniel_April_Jet.jpg/220px-Boykin_Spaniel_April_Jet.jpg"
  },
  {
    "breed": "Danish-Swedish Farmdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Danish_Farm_Dog1604fxcr_wb.jpg/220px-Danish_Farm_Dog1604fxcr_wb.jpg"
  },
  {
    "breed": "Finnish Spitz",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Finnish_Spitz_600.jpg/220px-Finnish_Spitz_600.jpg"
  },
  {
    "breed": "Great Dane",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Dog_niemiecki_%C5%BC%C3%B3%C5%82ty_LM980.jpg/220px-Dog_niemiecki_%C5%BC%C3%B3%C5%82ty_LM980.jpg"
  },
  {
    "breed": "Borzoi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Chart_rosyjski_borzoj_rybnik-kamien_pl.jpg/220px-Chart_rosyjski_borzoj_rybnik-kamien_pl.jpg"
  },
  {
    "breed": "Caucasian Shepherd Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Owczarek_kaukaski_65556.jpg/220px-Owczarek_kaukaski_65556.jpg"
  },
  {
    "breed": "Dandie Dinmont Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/63/Dandie_Dinmont_Terrier_600.jpg/220px-Dandie_Dinmont_Terrier_600.jpg"
  },
  {
    "breed": "Dogo Argentino",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/0Dogo-argentino-22122251920.jpg/220px-0Dogo-argentino-22122251920.jpg"
  },
  {
    "breed": "English Cocker Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/%22Bill%22_-_Cocker_spaniel_anglais_2.JPG/220px-%22Bill%22_-_Cocker_spaniel_anglais_2.JPG"
  },
  {
    "breed": "Australian Cattle Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/ACD-blue-spud.jpg/220px-ACD-blue-spud.jpg"
  },
  {
    "breed": "Black Russian Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Russianblack.jpg/220px-Russianblack.jpg"
  },
  {
    "breed": "Boston Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Boston_Terrier_Virginia.jpg/220px-Boston_Terrier_Virginia.jpg"
  },
  {
    "breed": "Chow Chow",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/ChowChow2Szczecin.jpg/220px-ChowChow2Szczecin.jpg"
  },
  {
    "breed": "Field Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Field_spaniel_581.jpg/220px-Field_spaniel_581.jpg"
  },
  {
    "breed": "German Shepherd Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/German_Shepherd_-_DSC_0346_%2810096362833%29.jpg/220px-German_Shepherd_-_DSC_0346_%2810096362833%29.jpg"
  },
  {
    "breed": "Irish Setter",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Can_Setter_dog_GFDL.jpg/220px-Can_Setter_dog_GFDL.jpg"
  },
  {
    "breed": "Irish Wolfhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/%282%29_Irish_Wolfhound_4.jpg/220px-%282%29_Irish_Wolfhound_4.jpg"
  },
  {
    "breed": "Miniature Schnauzer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/%D0%A6%D0%B2%D0%B5%D1%80%D0%B3%D1%88%D0%BD%D0%B0%D1%83%D1%86%D0%B5%D1%80_%D0%BE%D0%BA%D1%80%D0%B0%D1%81_%D1%87%D0%B5%D1%80%D0%BD%D1%8B%D0%B9_%D1%81_%D1%81%D0%B5%D1%80%D0%B5%D0%B1%D1%80%D0%BE%D0%BC.JPG/275px-%D0%A6%D0%B2%D0%B5%D1%80%D0%B3%D1%88%D0%BD%D0%B0%D1%83%D1%86%D0%B5%D1%80_%D0%BE%D0%BA%D1%80%D0%B0%D1%81_%D1%87%D0%B5%D1%80%D0%BD%D1%8B%D0%B9_%D1%81_%D1%81%D0%B5%D1%80%D0%B5%D0%B1%D1%80%D0%BE%D0%BC.JPG"
  },
  {
    "breed": "Norwegian Lundehund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Lundehund-2003.jpg/220px-Lundehund-2003.jpg"
  },
  {
    "breed": "Romanian Mioritic Shepherd Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Mioritic.jpg/220px-Mioritic.jpg"
  },
  {
    "breed": "Scottish Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Scottish_Terrier_Photo_of_Face.jpg/220px-Scottish_Terrier_Photo_of_Face.jpg"
  },
  {
    "breed": "English Foxhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/English_Foxhound_portrait.jpg/220px-English_Foxhound_portrait.jpg"
  },
  {
    "breed": "Giant Schnauzer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/GiantSchnauzer.jpg/220px-GiantSchnauzer.jpg"
  },
  {
    "breed": "Golden Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Golden_Retriever_Dukedestiny01_drvd.jpg/220px-Golden_Retriever_Dukedestiny01_drvd.jpg"
  },
  {
    "breed": "Grand Basset Griffon Vendéen",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/P_Basset_Griffon_Vendeen_600.jpg/220px-P_Basset_Griffon_Vendeen_600.jpg"
  },
  {
    "breed": "Afghan Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Afghan_dog_-_cropped.jpg/220px-Afghan_dog_-_cropped.jpg"
  },
  {
    "breed": "Affenpinscher",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Affenpinscher.jpg/220px-Affenpinscher.jpg"
  },
  {
    "breed": "American Eskimo Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/American_Eskimo_Dog_1.jpg/220px-American_Eskimo_Dog_1.jpg"
  },
  {
    "breed": "Basenji",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Basenji_Profile_%28loosercrop%29.jpg/220px-Basenji_Profile_%28loosercrop%29.jpg"
  },
  {
    "breed": "Black and Tan Coonhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Black_and_Tan_Coonhound.jpg/220px-Black_and_Tan_Coonhound.jpg"
  },
  {
    "breed": "Braque du Bourbonnais",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Braque_du_Bourbonnais.jpg/220px-Braque_du_Bourbonnais.jpg"
  },
  {
    "breed": "Hovawart",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Helos_11.jpg/220px-Helos_11.jpg"
  },
  {
    "breed": "Ibizan Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Podenco_z_ibizy_645.jpg/240px-Podenco_z_ibizy_645.jpg"
  },
  {
    "breed": "Brussels Griffon",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Monkey_Bizniz_Drama_Queen.jpg/220px-Monkey_Bizniz_Drama_Queen.jpg"
  },
  {
    "breed": "German Longhaired Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/DeutschLanghaarneu.jpg/220px-DeutschLanghaarneu.jpg"
  },
  {
    "breed": "Italian Greyhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Italian_Greyhound_standing_gray_%28cropped%29.jpg/220px-Italian_Greyhound_standing_gray_%28cropped%29.jpg"
  },
  {
    "breed": "Plott Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Bossplotthound.JPG/220px-Bossplotthound.JPG"
  },
  {
    "breed": "Rhodesian Ridgeback",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Rhodesian_ridgeback.jpg/220px-Rhodesian_ridgeback.jpg"
  },
  {
    "breed": "Sealyham Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/en/thumb/0/0a/Charmin_crufts_2009.jpg/220px-Charmin_crufts_2009.jpg"
  },
  {
    "breed": "Shiba Inu",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Shiba_Inu_%28Chinese_characters%29.svg/70px-Shiba_Inu_%28Chinese_characters%29.svg.png"
  },
  {
    "breed": "Swedish Lapphund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Svensk_lapphund.JPG/220px-Svensk_lapphund.JPG"
  },
  {
    "breed": "Japanese Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Japanese_Terrier_22.04.2012_2pl.jpg/220px-Japanese_Terrier_22.04.2012_2pl.jpg"
  },
  {
    "breed": "Puli",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/PuliBlack_wb.jpg/220px-PuliBlack_wb.jpg"
  },
  {
    "breed": "Silky Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Australian_Silky_Terrier_Alana_Of_Silky%27s_Dream.jpg/220px-Australian_Silky_Terrier_Alana_Of_Silky%27s_Dream.jpg"
  },
  {
    "breed": "Staffordshire Bull Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Staffordshire-bull-terrier-white-2748733.jpg/220px-Staffordshire-bull-terrier-white-2748733.jpg"
  },
  {
    "breed": "Swedish Vallhund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg/220px-V%C3%A4stg%C3%B6taspets_hane_5_%C3%A5r.jpg"
  },
  {
    "breed": "Treeing Tennessee Brindle",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Sienna_TTBD.jpg/220px-Sienna_TTBD.jpg"
  },
  {
    "breed": "Papillon",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/RileyPapillon.JPG/220px-RileyPapillon.JPG"
  },
  {
    "breed": "Parson Russell Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/05052881_PRT_braun_rau.jpg/220px-05052881_PRT_braun_rau.jpg"
  },
  {
    "breed": "Perro de Presa Canario",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Presacanariobody.jpg/220px-Presacanariobody.jpg"
  },
  {
    "breed": "Pug",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Mops_oct09_cropped2.jpg/220px-Mops_oct09_cropped2.jpg"
  },
  {
    "breed": "Saint Bernard",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Hummel_Vedor_vd_Robandahoeve.jpg/220px-Hummel_Vedor_vd_Robandahoeve.jpg"
  },
  {
    "breed": "Segugio Italiano",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Segugioitalianopelorasofulvo_%28cropped%29.JPG/220px-Segugioitalianopelorasofulvo_%28cropped%29.JPG"
  },
  {
    "breed": "Tibetan Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Tibetansk_spaniel.jpg/220px-Tibetansk_spaniel.jpg"
  },
  {
    "breed": "Weimaraner",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Weimaraner_wb.jpg/220px-Weimaraner_wb.jpg"
  },
  {
    "breed": "Wirehaired Vizsla",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Dr%C3%B3tosvizsla_vadat_%C3%A1ll.jpg/220px-Dr%C3%B3tosvizsla_vadat_%C3%A1ll.jpg"
  },
  {
    "breed": "German Pinscher",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Bvdb-duitse_pincher.jpg/220px-Bvdb-duitse_pincher.jpg"
  },
  {
    "breed": "Havanese",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/A_Havanese_judging.jpg/220px-A_Havanese_judging.jpg"
  },
  {
    "breed": "Australian Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Australian_Terrier_adult_male.jpg/220px-Australian_Terrier_adult_male.jpg"
  },
  {
    "breed": "Barbet",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Chien_de_race_Barbet.jpg/220px-Chien_de_race_Barbet.jpg"
  },
  {
    "breed": "Cairn Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Cairn-Terrier-Garten1.jpg/220px-Cairn-Terrier-Garten1.jpg"
  },
  {
    "breed": "Chinook",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Mountan_Laurel_Ajax_the_Chinook_dog.jpg/220px-Mountan_Laurel_Ajax_the_Chinook_dog.jpg"
  },
  {
    "breed": "Dachshund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Short-haired-Dachshund.jpg/220px-Short-haired-Dachshund.jpg"
  },
  {
    "breed": "Finnish Lapphund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Finnish_Lapphund_Glenchess_Revontuli.jpg/220px-Finnish_Lapphund_Glenchess_Revontuli.jpg"
  },
  {
    "breed": "Flat-Coated Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Flat_Coated_Retriever_-_black.jpg/220px-Flat_Coated_Retriever_-_black.jpg"
  },
  {
    "breed": "Beagle",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/55/Beagle_600.jpg/220px-Beagle_600.jpg"
  },
  {
    "breed": "Bedlington Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Boutchie_apres_championnat_004.JPG/220px-Boutchie_apres_championnat_004.JPG"
  },
  {
    "breed": "Dalmatian",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Dalmatiner_2.jpg/220px-Dalmatiner_2.jpg"
  },
  {
    "breed": "English Springer Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/English_Springer_Spaniel_in_Tallinn.JPG/220px-English_Springer_Spaniel_in_Tallinn.JPG"
  },
  {
    "breed": "Entlebucher Mountain Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Elio_v_Schaerlig_im_Juni_2007_klein.jpg/220px-Elio_v_Schaerlig_im_Juni_2007_klein.jpg"
  },
  {
    "breed": "German Wirehaired Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2b/GermanWirehrPtr1_wb.jpg/220px-GermanWirehrPtr1_wb.jpg"
  },
  {
    "breed": "Greyhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/GraceTheGreyhound.jpg/220px-GraceTheGreyhound.jpg"
  },
  {
    "breed": "Bearded Collie",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Bearded_Collie_600.jpg/220px-Bearded_Collie_600.jpg"
  },
  {
    "breed": "Bluetick Coonhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/BluetickCoonhound.jpg/220px-BluetickCoonhound.jpg"
  },
  {
    "breed": "Catahoula Leopard Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/02._Coahoma_Arkansas_Logan.jpg/220px-02._Coahoma_Arkansas_Logan.jpg"
  },
  {
    "breed": "Harrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/Harrier_tricolour.jpg/220px-Harrier_tricolour.jpg"
  },
  {
    "breed": "Australian Shepherd",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/Australian_Shepherd_red_bi.JPG/220px-Australian_Shepherd_red_bi.JPG"
  },
  {
    "breed": "Basset Fauve de Bretagne",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ad/Basset_Fauve_de_Bretagne_600.jpg/220px-Basset_Fauve_de_Bretagne_600.jpg"
  },
  {
    "breed": "Beauceron",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Owczarek_francuski_beauceron_009pl.jpg/220px-Owczarek_francuski_beauceron_009pl.jpg"
  },
  {
    "breed": "Clumber Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/40/Clumber_spaniel_rybnik_kamien_pppl.jpg/220px-Clumber_spaniel_rybnik_kamien_pppl.jpg"
  },
  {
    "breed": "Japanese Chin",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Chin_posing.jpg/220px-Chin_posing.jpg"
  },
  {
    "breed": "Lhasa Apso",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Aishia.jpg/220px-Aishia.jpg"
  },
  {
    "breed": "Pomeranian",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Pomeranian.JPG/220px-Pomeranian.JPG"
  },
  {
    "breed": "Russian Toy",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/RusskiyToyWelpe9Mon.JPG/220px-RusskiyToyWelpe9Mon.JPG"
  },
  {
    "breed": "Schapendoes",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Nederlandse-schapendoes-02.jpg/220px-Nederlandse-schapendoes-02.jpg"
  },
  {
    "breed": "Shih Tzu",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/df/Shihtzu_%28cropped%29.jpg/220px-Shihtzu_%28cropped%29.jpg"
  },
  {
    "breed": "Spanish Mastiff",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Spanish_Mastiff.JPG/220px-Spanish_Mastiff.JPG"
  },
  {
    "breed": "Kai Ken",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Kai-front.jpg/220px-Kai-front.jpg"
  },
  {
    "breed": "Norwegian Elkhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Norwegian_Elkhound.jpg/220px-Norwegian_Elkhound.jpg"
  },
  {
    "breed": "Old English Sheepdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Old_English_Sheepdog_%28side%29.jpg/220px-Old_English_Sheepdog_%28side%29.jpg"
  },
  {
    "breed": "Rafeiro do Alentejo",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Rafeiro_male.jpg/220px-Rafeiro_male.jpg"
  },
  {
    "breed": "Irish Red and White Setter",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Irish_Red_And_White_Setter_2005.jpg/220px-Irish_Red_And_White_Setter_2005.jpg"
  },
  {
    "breed": "Miniature Pinscher",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Miniature_pinscher.jpg/220px-Miniature_pinscher.jpg"
  },
  {
    "breed": "Nova Scotia Duck Tolling Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Duck_Toller.jpg/220px-Duck_Toller.jpg"
  },
  {
    "breed": "Porcelaine",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Porcelaine_2009_pl4.jpg/220px-Porcelaine_2009_pl4.jpg"
  },
  {
    "breed": "Saluki",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Red_Smooth_Saluki.jpg/220px-Red_Smooth_Saluki.jpg"
  },
  {
    "breed": "Samoyed",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Samojed00.jpg/220px-Samojed00.jpg"
  },
  {
    "breed": "Shetland Sheepdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shetland_Sheepdog_600.jpg/220px-Shetland_Sheepdog_600.jpg"
  },
  {
    "breed": "Sloughi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/Sloughi_sandcolor.jpg/220px-Sloughi_sandcolor.jpg"
  },
  {
    "breed": "Thai Ridgeback",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/Thai-Ridgeback.jpg/220px-Thai-Ridgeback.jpg"
  },
  {
    "breed": "Tosa",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/BUKADAI_2.jpg/220px-BUKADAI_2.jpg"
  },
  {
    "breed": "Pharaoh Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Pies_faraona_e34.jpg/220px-Pies_faraona_e34.jpg"
  },
  {
    "breed": "Portuguese Podengo",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c6/Evitarocks.jpg/220px-Evitarocks.jpg"
  },
  {
    "breed": "Smooth Fox Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Patrick_the_Smooth_Fox_Terrier.jpg/220px-Patrick_the_Smooth_Fox_Terrier.jpg"
  },
  {
    "breed": "Spanish Water Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Perro_agua.jpg/220px-Perro_agua.jpg"
  },
  {
    "breed": "Taiwan Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Formosan_nina.jpg/220px-Formosan_nina.jpg"
  },
  {
    "breed": "Whippet",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/WhippetWhiteSaddled_wb.jpg/220px-WhippetWhiteSaddled_wb.jpg"
  },
  {
    "breed": "Bloodhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Bloodhound_Erland22.jpg/220px-Bloodhound_Erland22.jpg"
  },
  {
    "breed": "Lapponian Herder",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Lapskvallhund.jpg/220px-Lapskvallhund.jpg"
  },
  {
    "breed": "Cane Corso",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/CaneCorso_%2823%29.jpg/220px-CaneCorso_%2823%29.jpg"
  },
  {
    "breed": "Volpino Italiano",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Szpic_miniaturowy_Volpino_MWPR_Katowice_2008_%28cropped%29.JPG/220px-Szpic_miniaturowy_Volpino_MWPR_Katowice_2008_%28cropped%29.JPG"
  },
  {
    "breed": "Lancashire Heeler",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Lancashire_Heeler_600.jpg/220px-Lancashire_Heeler_600.jpg"
  },
  {
    "breed": "Löwchen",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Adult_Lowchen_Gaiting.jpg/220px-Adult_Lowchen_Gaiting.jpg"
  },
  {
    "breed": "Maltese",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Maltese_600.jpg/220px-Maltese_600.jpg"
  },
  {
    "breed": "Polish Lowland Sheepdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/22/Polski_owczarek_nizinny_rybnik-kamien_pl.jpg/220px-Polski_owczarek_nizinny_rybnik-kamien_pl.jpg"
  },
  {
    "breed": "Portuguese Water Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/C%C3%A3o_de_agua_Portugu%C3%AAs_2.jpg/220px-C%C3%A3o_de_agua_Portugu%C3%AAs_2.jpg"
  },
  {
    "breed": "Pumi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Pumi_2.jpg/220px-Pumi_2.jpg"
  },
  {
    "breed": "Irish Water Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Irlandzki_spaniel_wodny_676.jpg/220px-Irlandzki_spaniel_wodny_676.jpg"
  },
  {
    "breed": "Keeshond",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Keeshond_Majic_standing_cropped.jpg/220px-Keeshond_Majic_standing_cropped.jpg"
  },
  {
    "breed": "Mudi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Hondenras_Mudi.jpg/220px-Hondenras_Mudi.jpg"
  },
  {
    "breed": "Pembroke Welsh Corgi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Welchcorgipembroke.JPG/220px-Welchcorgipembroke.JPG"
  },
  {
    "breed": "Petit Basset Griffon Vendéen",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/P_Basset_Griffon_Vendeen_600.jpg/220px-P_Basset_Griffon_Vendeen_600.jpg"
  },
  {
    "breed": "Skye Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Skye_terrier_800.jpg/220px-Skye_terrier_800.jpg"
  },
  {
    "breed": "Stabyhoun",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Frisianstaby.jpg/220px-Frisianstaby.jpg"
  },
  {
    "breed": "Wire Fox Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/Elias1%C4%8Derven2006.jpg/220px-Elias1%C4%8Derven2006.jpg"
  },
  {
    "breed": "Brittany",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/American_Brittany_standing.jpg/220px-American_Brittany_standing.jpg"
  },
  {
    "breed": "Carolina Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg/220px-Dakota%2C_the_Dixie_Dingo_%28or_Carolina_Dog%29.jpg"
  },
  {
    "breed": "Estrela Mountain Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1c/Estrela_Mountain_Dog_6_month_old_male.jpg/220px-Estrela_Mountain_Dog_6_month_old_male.jpg"
  },
  {
    "breed": "Greater Swiss Mountain Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/Greater_Swiss_Mountain_Dog_2018.jpg/220px-Greater_Swiss_Mountain_Dog_2018.jpg"
  },
  {
    "breed": "Australian Stumpy Tail Cattle Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Australian_Stumpy_Tail_Cattle_Dog.jpg/220px-Australian_Stumpy_Tail_Cattle_Dog.jpg"
  },
  {
    "breed": "Rottweiler",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Rottweiler_standing_facing_left.jpg/220px-Rottweiler_standing_facing_left.jpg"
  },
  {
    "breed": "English Setter",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/EnglishSetter9_fx_wb.jpg/220px-EnglishSetter9_fx_wb.jpg"
  },
  {
    "breed": "Labrador Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Labrador_on_Quantock_%282175262184%29.jpg/220px-Labrador_on_Quantock_%282175262184%29.jpg"
  },
  {
    "breed": "Jindo",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Peeb_the_Korea_Jindo_Dog.jpg/220px-Peeb_the_Korea_Jindo_Dog.jpg"
  },
  {
    "breed": "Kuvasz",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Kuvasz_named_Kan.jpg/220px-Kuvasz_named_Kan.jpg"
  },
  {
    "breed": "Miniature Bull Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4d/Bull_terier_i_bull_terier_miniatura_d46.jpg/220px-Bull_terier_i_bull_terier_miniatura_d46.jpg"
  },
  {
    "breed": "Portuguese Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Portuguese_pointer_11yo.jpg/220px-Portuguese_pointer_11yo.jpg"
  },
  {
    "breed": "Rat Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/AmRatTerr2_wb.jpg/220px-AmRatTerr2_wb.jpg"
  },
  {
    "breed": "Teddy Roosevelt Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Teddyterrier.jpg/220px-Teddyterrier.jpg"
  },
  {
    "breed": "Tornjak",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Bosniantornjak.jpg/220px-Bosniantornjak.jpg"
  },
  {
    "breed": "Welsh Springer Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Welsh_Springer_Spaniel_1.jpg/220px-Welsh_Springer_Spaniel_1.jpg"
  },
  {
    "breed": "West Highland White Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/West_Highland_White_Terrier_Krakow.jpg/220px-West_Highland_White_Terrier_Krakow.jpg"
  },
  {
    "breed": "Jagdterrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Jagdterrier_bulgaria.jpg/220px-Jagdterrier_bulgaria.jpg"
  },
  {
    "breed": "Norfolk Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Norfolk_terrier_CAC.jpg/220px-Norfolk_terrier_CAC.jpg"
  },
  {
    "breed": "Otterhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Two_otterhounds.jpg/220px-Two_otterhounds.jpg"
  },
  {
    "breed": "Treeing Walker Coonhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Treeing-walker-coonhound-standing.jpg/220px-Treeing-walker-coonhound-standing.jpg"
  },
  {
    "breed": "Drever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Drever_NUCh_Tanjo.jpg/220px-Drever_NUCh_Tanjo.jpg"
  },
  {
    "breed": "Dutch Shepherd",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Short-haired_Dutch_Shepherd%C2%A9CaroleField.jpg/220px-Short-haired_Dutch_Shepherd%C2%A9CaroleField.jpg"
  },
  {
    "breed": "Welsh Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Terier_walijski_suka_2009_pl.jpg/220px-Terier_walijski_suka_2009_pl.jpg"
  },
  {
    "breed": "American English Coonhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/English_Coonhound.jpg/220px-English_Coonhound.jpg"
  },
  {
    "breed": "Boxer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Male_fawn_Boxer_undocked.jpg/220px-Male_fawn_Boxer_undocked.jpg"
  },
  {
    "breed": "Coton de Tulear",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Coton_de_Tular_1.jpg/220px-Coton_de_Tular_1.jpg"
  },
  {
    "breed": "Leonberger",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Leonberger_male.jpg/220px-Leonberger_male.jpg"
  },
  {
    "breed": "Newfoundland",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Newfoundland_dog_Smoky.jpg/220px-Newfoundland_dog_Smoky.jpg"
  },
  {
    "breed": "Norwegian Buhund",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Norwegian_Buhund_600.jpg/220px-Norwegian_Buhund_600.jpg"
  },
  {
    "breed": "Irish Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/IrishTerrierSydenhamHillWoods.jpg/220px-IrishTerrierSydenhamHillWoods.jpg"
  },
  {
    "breed": "Japanese Spitz",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/JapaneseSpitzPhoto1_-_hiro.jpg/220px-JapaneseSpitzPhoto1_-_hiro.jpg"
  },
  {
    "breed": "Neapolitan Mastiff",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Mastino_Napoletano_R%C3%BCde_clp.JPG/220px-Mastino_Napoletano_R%C3%BCde_clp.JPG"
  },
  {
    "breed": "Pudelpointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Pudelpointer_on_point.jpg/220px-Pudelpointer_on_point.jpg"
  },
  {
    "breed": "Siberian Husky",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Husky_L.jpg/220px-Husky_L.jpg"
  },
  {
    "breed": "Slovakian Wirehaired Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/ICh_Brita_z_Ruzenice.jpg/220px-ICh_Brita_z_Ruzenice.jpg"
  },
  {
    "breed": "Karelian Bear Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Karelski_pies_na_nied%C5%BAwiedzie_sylwetka.JPG/220px-Karelski_pies_na_nied%C5%BAwiedzie_sylwetka.JPG"
  },
  {
    "breed": "Komondor",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Komondor_delvin.jpg/220px-Komondor_delvin.jpg"
  },
  {
    "breed": "Mountain Cur",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Mtncur.png/220px-Mtncur.png"
  },
  {
    "breed": "Norwich Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/Norwichterrier.jpg/220px-Norwichterrier.jpg"
  },
  {
    "breed": "Tibetan Mastiff",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Adventure%2C_sport_and_travel_on_the_Tibetan_steppes_%281911%29_%2814597105527%29.jpg/220px-Adventure%2C_sport_and_travel_on_the_Tibetan_steppes_%281911%29_%2814597105527%29.jpg"
  },
  {
    "breed": "Vizsla",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Wy%C5%BCe%C5%82_w%C4%99gierski_g%C5%82adkow%C5%82osy_500.jpg/220px-Wy%C5%BCe%C5%82_w%C4%99gierski_g%C5%82adkow%C5%82osy_500.jpg"
  },
  {
    "breed": "Broholmer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Male_Broholmer.jpg/220px-Male_Broholmer.jpg"
  },
  {
    "breed": "Bullmastiff",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Bullmastiff_edited.JPG/220px-Bullmastiff_edited.JPG"
  },
  {
    "breed": "American Bulldog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/Faithfullbull_Spike_of_Mightybull.jpg/220px-Faithfullbull_Spike_of_Mightybull.jpg"
  },
  {
    "breed": "Chesapeake Bay Retriever",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/CH_Chesapeake.jpg/220px-CH_Chesapeake.jpg"
  },
  {
    "breed": "Schipperke",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Schipperke0001.jpg/220px-Schipperke0001.jpg"
  },
  {
    "breed": "Bernese Mountain Dog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Othello.jpg/220px-Othello.jpg"
  },
  {
    "breed": "French Bulldog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/2008-07-28_Dog_at_Frolick_Field.jpg/220px-2008-07-28_Dog_at_Frolick_Field.jpg"
  },
  {
    "breed": "Icelandic Sheepdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Icelandic_Sheepdog_Alisa_von_Lehenberg.jpg/220px-Icelandic_Sheepdog_Alisa_von_Lehenberg.jpg"
  },
  {
    "breed": "Bracco Italiano",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Giotto_BI.jpg/220px-Giotto_BI.jpg"
  },
  {
    "breed": "Glen of Imaal Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Wheaten_glen_of_imaal.jpg/220px-Wheaten_glen_of_imaal.jpg"
  },
  {
    "breed": "Lakeland Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Lakeland_Terrier.jpg/220px-Lakeland_Terrier.jpg"
  },
  {
    "breed": "Peruvian Inca Orchid",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/PHDStandardStanding_-_Perro_Sin_Pelo_del_Per%C3%BA.jpg/220px-PHDStandardStanding_-_Perro_Sin_Pelo_del_Per%C3%BA.jpg"
  },
  {
    "breed": "Cardigan Welsh Corgi",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Cardigan_Welsh_Corgi%2C_Profile.png/220px-Cardigan_Welsh_Corgi%2C_Profile.png"
  },
  {
    "breed": "Tibetan Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Tibet_Terrier_Bennie_%28cropped%29.jpg/220px-Tibet_Terrier_Bennie_%28cropped%29.jpg"
  },
  {
    "breed": "Kerry Blue Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Kerry_Blue_Terrier.jpg/220px-Kerry_Blue_Terrier.jpg"
  },
  {
    "breed": "Lagotto Romagnolo",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Lagotto_Romagnolo.jpg/220px-Lagotto_Romagnolo.jpg"
  },
  {
    "breed": "Pekingese",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/1AKC_Pekingese_Dog_Show_2011.jpg/220px-1AKC_Pekingese_Dog_Show_2011.jpg"
  },
  {
    "breed": "Pointer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/English_Pointer_orange-white.jpg/220px-English_Pointer_orange-white.jpg"
  },
  {
    "breed": "Pyrenean Mastiff",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/MasPiri-Lula-ESP.jpg/220px-MasPiri-Lula-ESP.jpg"
  },
  {
    "breed": "Redbone Coonhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Redbone-coonhound-detail.jpg/220px-Redbone-coonhound-detail.jpg"
  },
  {
    "breed": "Scottish Deerhound",
    "img":
        "https://upload.wikimedia.org/wikipedia/en/thumb/5/5b/Deerhound_Fernhill%27s_Kendra.jpg/220px-Deerhound_Fernhill%27s_Kendra.jpg"
  },
  {
    "breed": "Shikoku",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Shikokuken.jpg/220px-Shikokuken.jpg"
  },
  {
    "breed": "Sussex Spaniel",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Sussex_spaniel_t43.jpg/220px-Sussex_spaniel_t43.jpg"
  },
  {
    "breed": "Transylvanian Hound",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/Erdelyi_kopo_VadaszNimrodSzeder01.jpg/220px-Erdelyi_kopo_VadaszNimrodSzeder01.jpg"
  },
  {
    "breed": "Wetterhoun",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Fryzyjski_pies_wodny_u68.jpg/220px-Fryzyjski_pies_wodny_u68.jpg"
  },
  {
    "breed": "Miniature American Shepherd",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Blue_Merle_Miniature_American_Shepherd_in_Grass.jpg/220px-Blue_Merle_Miniature_American_Shepherd_in_Grass.jpg"
  },
  {
    "breed": "Norrbottenspets",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Nordic_Spitz.jpg/220px-Nordic_Spitz.jpg"
  },
  {
    "breed": "Spinone Italiano",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/05042363_Spinone_braun.jpg/220px-05042363_Spinone_braun.jpg"
  },
  {
    "breed": "Standard Schnauzer",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a1/Emppumenossa.jpg/220px-Emppumenossa.jpg"
  },
  {
    "breed": "Wirehaired Pointing Griffon",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg/220px-GCH_Int_Ch_UCH_Zerubbabel_von_Herrenhausen_CGC_MHA.jpg"
  },
  {
    "breed": "Yakutian Laika",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Yl01.jpg/220px-Yl01.jpg"
  },
  {
    "breed": "Yorkshire Terrier",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/%282_version%29_Grupp_3%2C_YORKSHIRETERRIER%2C_NO_UCH_SE_UCH_Oxzar_Amazing_Bel%E2%80%99s_Toffy_%2824310212305%29.jpg/220px-%282_version%29_Grupp_3%2C_YORKSHIRETERRIER%2C_NO_UCH_SE_UCH_Oxzar_Amazing_Bel%E2%80%99s_Toffy_%2824310212305%29.jpg"
  },
  {
    "breed": "Croatian Sheepdog",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/GeraHojda09112055ZG.jpeg/220px-GeraHojda09112055ZG.jpeg"
  },
  {
    "breed": "Bouvier des Flandres",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/Bouvier.JPG/220px-Bouvier.JPG"
  },
  {
    "breed": "German Spitz",
    "img":
        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Pomeranian_orange-sable_Coco.jpg/220px-Pomeranian_orange-sable_Coco.jpg"
  }
];
