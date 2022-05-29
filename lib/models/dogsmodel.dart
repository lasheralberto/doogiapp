// ignore_for_file: non_constant_identifier_names


class DogClass {
  Id? _id;
  String? _breed;
  String? _origin;
  String? _url;
  String? _img;
  dynamic _goodWithChildren;
  dynamic _goodWithOtherDogs;
  dynamic _shedding;
  dynamic _grooming;
  dynamic _drooling;
  dynamic _coatLength;
  dynamic _goodWithStrangers;
  dynamic _playfulness;
  dynamic _protectiveness;
  dynamic _trainability;
  dynamic _energy;
  dynamic _barking;
  dynamic _minLifeExpectancy;
  dynamic _maxLifeExpectancy;
  dynamic _maxHeightMale;
  dynamic _maxHeightFemale;
  dynamic _maxWeightMale;
  dynamic _maxWeightFemale;
  dynamic _minHeightMale;
  dynamic _minHeightFemale;
  dynamic _minWeightMale;
  dynamic _minWeightFemale;
  List<WikiDescr>? _wikiDescr;
  List<Urls2>? _urls2;

  DogClass(
      {Id? id,
      String? breed,
      String? origin,
      String? url,
      String? img,
      List<WikiDescr>? wikiDescr,
      dynamic goodWithChildren,
      dynamic goodWithOtherDogs,
      dynamic shedding,
      dynamic grooming,
      dynamic drooling,
      dynamic coatLength,
      dynamic goodWithStrangers,
      dynamic playfulness,
      dynamic protectiveness,
      dynamic trainability,
      dynamic energy,
      dynamic barking,
      dynamic minLifeExpectancy,
      dynamic maxLifeExpectancy,
      dynamic maxHeightMale,
      dynamic maxHeightFemale,
      dynamic maxWeightMale,
      dynamic maxWeightFemale,
      dynamic minHeightMale,
      dynamic minHeightFemale,
      dynamic minWeightMale,
      dynamic minWeightFemale,
      List<Urls2>? urls2}) {
    if (id != null) {
      _id = id;
    }
    if (breed != null) {
      _breed = breed;
    }
    if (origin != null) {
      _origin = origin;
    }
    if (url != null) {
      _url = url;
    }
    if (img != null) {
      _img = img;
    }

    if (wikiDescr != null) {
      _wikiDescr = wikiDescr;
    }

    if (goodWithChildren != null) {
      _goodWithChildren = goodWithChildren;
    }
    if (goodWithOtherDogs != null) {
      _goodWithOtherDogs = goodWithOtherDogs;
    }
    if (shedding != null) {
      _shedding = shedding;
    }
    if (grooming != null) {
      _grooming = grooming;
    }
    if (drooling != null) {
      _drooling = drooling;
    }
    if (coatLength != null) {
      _coatLength = coatLength;
    }
    if (goodWithStrangers != null) {
      _goodWithStrangers = goodWithStrangers;
    }
    if (playfulness != null) {
      _playfulness = playfulness;
    }
    if (protectiveness != null) {
      _protectiveness = protectiveness;
    }
    if (trainability != null) {
      _trainability = trainability;
    }
    if (energy != null) {
      _energy = energy;
    }
    if (barking != null) {
      _barking = barking;
    }
    if (minLifeExpectancy != null) {
      _minLifeExpectancy = minLifeExpectancy;
    }
    if (maxLifeExpectancy != null) {
      _maxLifeExpectancy = maxLifeExpectancy;
    }
    if (maxHeightMale != null) {
      _maxHeightMale = maxHeightMale;
    }
    if (maxHeightFemale != null) {
      _maxHeightFemale = maxHeightFemale;
    }
    if (maxWeightMale != null) {
      _maxWeightMale = maxWeightMale;
    }
    if (maxWeightFemale != null) {
      _maxWeightFemale = maxWeightFemale;
    }
    if (minHeightMale != null) {
      _minHeightMale = minHeightMale;
    }
    if (minHeightFemale != null) {
      _minHeightFemale = minHeightFemale;
    }
    if (minWeightMale != null) {
      _minWeightMale = minWeightMale;
    }
    if (minWeightFemale != null) {
      _minWeightFemale = minWeightFemale;
    }
    if (urls2 != null) {
      _urls2 = urls2;
    }
  }

  Id? get id => _id;
  set iId(Id? iId) => _id = iId;
  String? get breed => _breed;
  set breed(String? breed) => _breed = breed;
  String? get origin => _origin;
  set origin(String? origin) => _origin = origin;
  String? get url => _url;
  set url(String? url) => _url = url;
  String? get img => _img;
  set img(String? img) => _img = img;
  List<WikiDescr>? get wikiDescr => _wikiDescr;
  set wikiDescr(List<WikiDescr>? wikiDescr) => _wikiDescr = wikiDescr;

  dynamic get goodWithChildren => _goodWithChildren;
  set goodWithChildren(dynamic goodWithChildren) =>
      _goodWithChildren = goodWithChildren;
  dynamic get goodWithOtherDogs => _goodWithOtherDogs;
  set goodWithOtherDogs(dynamic goodWithOtherDogs) =>
      _goodWithOtherDogs = goodWithOtherDogs;
  dynamic get shedding => _shedding;
  set shedding(dynamic shedding) => _shedding = shedding;
  dynamic get grooming => _grooming;
  set grooming(dynamic grooming) => _grooming = grooming;
  dynamic get drooling => _drooling;
  set drooling(dynamic drooling) => _drooling = drooling;
  dynamic get coatLength => _coatLength;
  set coatLength(dynamic coatLength) => _coatLength = coatLength;
  dynamic get goodWithStrangers => _goodWithStrangers;
  set goodWithStrangers(dynamic goodWithStrangers) =>
      _goodWithStrangers = goodWithStrangers;
  dynamic get playfulness => _playfulness;
  set playfulness(dynamic playfulness) => _playfulness = playfulness;
  dynamic get protectiveness => _protectiveness;
  set protectiveness(dynamic protectiveness) =>
      _protectiveness = protectiveness;
  dynamic get trainability => _trainability;
  set trainability(dynamic trainability) => _trainability = trainability;
  dynamic get energy => _energy;
  set energy(dynamic energy) => _energy = energy;
  dynamic get barking => _barking;
  set barking(dynamic barking) => _barking = barking;
  dynamic get minLifeExpectancy => _minLifeExpectancy;
  set minLifeExpectancy(dynamic minLifeExpectancy) =>
      _minLifeExpectancy = minLifeExpectancy;
  dynamic get maxLifeExpectancy => _maxLifeExpectancy;
  set maxLifeExpectancy(dynamic maxLifeExpectancy) =>
      _maxLifeExpectancy = maxLifeExpectancy;
  dynamic get maxHeightMale => _maxHeightMale;
  set maxHeightMale(dynamic maxHeightMale) => _maxHeightMale = maxHeightMale;
  dynamic get maxHeightFemale => _maxHeightFemale;
  set maxHeightFemale(dynamic maxHeightFemale) =>
      _maxHeightFemale = maxHeightFemale;
  dynamic get maxWeightMale => _maxWeightMale;
  set maxWeightMale(dynamic maxWeightMale) => _maxWeightMale = maxWeightMale;
  dynamic get maxWeightFemale => _maxWeightFemale;
  set maxWeightFemale(dynamic maxWeightFemale) =>
      _maxWeightFemale = maxWeightFemale;
  dynamic get minHeightMale => _minHeightMale;
  set minHeightMale(dynamic minHeightMale) => _minHeightMale = minHeightMale;
  dynamic get minHeightFemale => _minHeightFemale;
  set minHeightFemale(dynamic minHeightFemale) =>
      _minHeightFemale = minHeightFemale;
  dynamic get minWeightMale => _minWeightMale;
  set minWeightMale(dynamic minWeightMale) => _minWeightMale = minWeightMale;
  dynamic get minWeightFemale => _minWeightFemale;
  set minWeightFemale(dynamic minWeightFemale) =>
      _minWeightFemale = minWeightFemale;
  List<Urls2>? get urls2 => _urls2;
  set urls2(List<Urls2>? urls2) => _urls2 = urls2;

  factory DogClass.fromJson(Map<dynamic, dynamic> json) {
    return DogClass(
      id: Id.fromJson(json["_id"]),
      breed: json["breed"],
      origin: json["origin"],
      url: json["url"],
      img: json["img"],
      wikiDescr: List<WikiDescr>.from(
          json["WikiDescr"].map((x) => WikiDescr.fromJson(x))),
      goodWithChildren: json["good_with_children"],
      goodWithOtherDogs: json["good_with_other_dogs"],
      shedding: json["shedding"],
      grooming: json["grooming"],
      drooling: json["drooling"],
      coatLength: json["coat_length"],
      goodWithStrangers: json["good_with_strangers"],
      playfulness: json["playfulness"],
      protectiveness: json["protectiveness"],
      trainability: json["trainability"],
      energy: json["energy"],
      barking: json["barking"],
      minLifeExpectancy: json["min_life_expectancy"],
      maxLifeExpectancy: json["max_life_expectancy"],
      maxHeightMale: json["max_height_male"],
      maxHeightFemale: json["max_height_female"],
      maxWeightMale: json["max_weight_male"],
      maxWeightFemale: json["max_weight_female"],
      minHeightMale: json["min_height_male"],
      minHeightFemale: json["min_height_female"],
      minWeightMale: json["min_weight_male"],
      minWeightFemale: json["min_weight_female"],
      urls2: List<Urls2>.from(json["urls2"].map((x) => Urls2.fromJson(x))),
    );
  }
}

class Id {
  String? _oid;

  Id({String? oid}) {
    if (oid != null) {
      _oid = oid;
    }
  }

  String? get oid => _oid;
  set oid(String? oid) => _oid = oid;

  Id.fromJson(Map<String, dynamic> json) {
    _oid = json['$oid'];
  }
}

class WikiDescr {
  WikiDescr({required this.contenido});

  String contenido;

  factory WikiDescr.fromJson(Map<String, dynamic> json) => WikiDescr(
        contenido: json["contenido"],
      );
}



class Urls2 {
    Urls2({
        required this.id,
        required this.breed,
        required this.urlBreed,
    });

    Id id;
    String breed;
    List<String> urlBreed;

    factory Urls2.fromJson(Map<dynamic, dynamic> json) => Urls2(
        id: Id.fromJson(json["_id"]),
        breed: json["breed"],
        urlBreed: List<String>.from(json["url_breed"].map((x) => x)),
    );

}