// To parse this JSON data, do
//
//     final nbaOyunculari = nbaOyunculariFromJson(jsonString);

import 'dart:convert';

NbaOyunculari nbaOyunculariFromJson(String str) =>
    NbaOyunculari.fromJson(json.decode(str));

String nbaOyunculariToJson(NbaOyunculari data) => json.encode(data.toJson());

class NbaOyunculari {
  NbaOyunculari({
    this.data,
    this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory NbaOyunculari.fromJson(Map<String, dynamic> json) => NbaOyunculari(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class Datum {
  Datum({
    this.id,
    this.firstName,
    this.heightFeet,
    this.heightInches,
    this.lastName,
    this.position,
    this.team,
    this.weightPounds,
  });

  int id;
  String firstName;
  int heightFeet;
  int heightInches;
  String lastName;
  String position;
  Team team;
  int weightPounds;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["first_name"],
        heightFeet: json["height_feet"] == null ? null : json["height_feet"],
        heightInches:
            json["height_inches"] == null ? null : json["height_inches"],
        lastName: json["last_name"],
        position: json["position"],
        team: Team.fromJson(json["team"]),
        weightPounds:
            json["weight_pounds"] == null ? null : json["weight_pounds"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "height_feet": heightFeet == null ? null : heightFeet,
        "height_inches": heightInches == null ? null : heightInches,
        "last_name": lastName,
        "position": position,
        "team": team.toJson(),
        "weight_pounds": weightPounds == null ? null : weightPounds,
      };
}

class Team {
  Team({
    this.id,
    this.abbreviation,
    this.city,
    this.conference,
    this.division,
    this.fullName,
    this.name,
  });

  int id;
  String abbreviation;
  String city;
  Conference conference;
  String division;
  String fullName;
  String name;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        abbreviation: json["abbreviation"],
        city: json["city"],
        conference: conferenceValues.map[json["conference"]],
        division: json["division"],
        fullName: json["full_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "abbreviation": abbreviation,
        "city": city,
        "conference": conferenceValues.reverse[conference],
        "division": division,
        "full_name": fullName,
        "name": name,
      };
}

enum Conference { EAST, WEST }

final conferenceValues =
    EnumValues({"East": Conference.EAST, "West": Conference.WEST});

class Meta {
  Meta({
    this.totalPages,
    this.currentPage,
    this.nextPage,
    this.perPage,
    this.totalCount,
  });

  int totalPages;
  int currentPage;
  int nextPage;
  int perPage;
  int totalCount;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalPages: json["total_pages"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
        perPage: json["per_page"],
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
        "current_page": currentPage,
        "next_page": nextPage,
        "per_page": perPage,
        "total_count": totalCount,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
