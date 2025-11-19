class CityModelResponse {
    final String name;
    final double lat;
    final double lon;
    final String country;
    final String state;
    final LocalNames? localNames;

    CityModelResponse({
        required this.name,
        required this.lat,
        required this.lon,
        required this.country,
        required this.state,
        this.localNames,
    });

    factory CityModelResponse.fromJson(Map<String, dynamic> json) => CityModelResponse(
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        country: json["country"],
        state: json["state"],
        localNames: json["local_names"] == null ? null : LocalNames.fromJson(json["local_names"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
        "local_names": localNames?.toJson(),
    };
}

class LocalNames {
    final String en;

    LocalNames({
        required this.en,
    });

    factory LocalNames.fromJson(Map<String, dynamic> json) => LocalNames(
        en: json["en"],
    );

    Map<String, dynamic> toJson() => {
        "en": en,
    };
}
