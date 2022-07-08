class MLmodel {
  MLmodel({
    this.id,
    this.playfulness,
    this.energy,
    this.barking,
    this.predictedBreeds,
    this.predictedValue,
    this.accuracy,
  });

  Id? id;
  int? playfulness;
  int? energy;
  int? barking;
  String? predictedBreeds;
  int? predictedValue;
  double? accuracy;

  factory MLmodel.fromJson(Map<String, dynamic> json) {
    return MLmodel(
      id: Id.fromJson(json["_id"]),
      playfulness: json["playfulness"],
      energy: json["energy"],
      barking: json["barking"],
      predictedBreeds:
         json["predictedBreeds"],
      predictedValue: json["predicted_value"],
      accuracy: json["accuracy"].toDouble(),
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
