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
    List<String>? predictedBreeds;
    int? predictedValue;
    double? accuracy;

    factory MLmodel.fromJson(Map<String, dynamic> json) => MLmodel(
        id: Id.fromJson(json["_id"]),
        playfulness: json["playfulness"],
        energy: json["energy"],
        barking: json["barking"],
        predictedBreeds: List<String>.from(json["predicted_breeds"].map((x) => x)),
        predictedValue: json["predicted_value"],
        accuracy: json["accuracy"].toDouble(),
    );

 
}

class Id {
    Id({
        this.oid,
    });

    String? oid;

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
    );


}
