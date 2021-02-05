// To parse this JSON data, do
//
//     final nbaGame = nbaGameFromJson(jsonString);

import 'dart:convert';

NbaGame nbaGameFromJson(String str) => NbaGame.fromJson(json.decode(str));

String nbaGameToJson(NbaGame data) => json.encode(data.toJson());

class NbaGame {
  NbaGame({
    this.data,
    this.meta,
  });

  List<Datum> data;
  Meta meta;

  factory NbaGame.fromJson(Map<String, dynamic> json) => NbaGame(
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
    this.date,
    this.homeTeam,
    this.homeTeamScore,
    this.period,
    this.postseason,
    this.season,
    this.status,
    this.time,
    this.visitorTeam,
    this.visitorTeamScore,
  });

  int id;
  DateTime date;
  Team homeTeam;
  int homeTeamScore;
  int period;
  bool postseason;
  int season;
  Status status;
  String time;
  Team visitorTeam;
  int visitorTeamScore;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        homeTeam: Team.fromJson(json["home_team"]),
        homeTeamScore: json["home_team_score"],
        period: json["period"],
        postseason: json["postseason"],
        season: json["season"],
        status: statusValues.map[json["status"]],
        time: json["time"],
        visitorTeam: Team.fromJson(json["visitor_team"]),
        visitorTeamScore: json["visitor_team_score"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "home_team": homeTeam.toJson(),
        "home_team_score": homeTeamScore,
        "period": period,
        "postseason": postseason,
        "season": season,
        "status": statusValues.reverse[status],
        "time": time,
        "visitor_team": visitorTeam.toJson(),
        "visitor_team_score": visitorTeamScore,
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
  Division division;
  String fullName;
  String name;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        abbreviation: json["abbreviation"],
        city: json["city"],
        conference: conferenceValues.map[json["conference"]],
        division: divisionValues.map[json["division"]],
        fullName: json["full_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "abbreviation": abbreviation,
        "city": city,
        "conference": conferenceValues.reverse[conference],
        "division": divisionValues.reverse[division],
        "full_name": fullName,
        "name": name,
      };
}

enum Conference { EAST, WEST }

final conferenceValues =
    EnumValues({"East": Conference.EAST, "West": Conference.WEST});

enum Division { ATLANTIC, PACIFIC, SOUTHEAST, CENTRAL, NORTHWEST, SOUTHWEST }

final divisionValues = EnumValues({
  "Atlantic": Division.ATLANTIC,
  "Central": Division.CENTRAL,
  "Northwest": Division.NORTHWEST,
  "Pacific": Division.PACIFIC,
  "Southeast": Division.SOUTHEAST,
  "Southwest": Division.SOUTHWEST
});

enum Status {
  FINAL,
  THE_800_PM_ET,
  THE_1000_PM_ET,
  THE_700_PM_ET,
  THE_730_PM_ET,
  THE_600_PM_ET,
  THE_900_PM_ET,
  THE_830_PM_ET,
  THE_200_PM_ET
}

final statusValues = EnumValues({
  "Final": Status.FINAL,
  "10:00 PM ET": Status.THE_1000_PM_ET,
  "2:00 PM ET": Status.THE_200_PM_ET,
  "6:00 PM ET": Status.THE_600_PM_ET,
  "7:00 PM ET": Status.THE_700_PM_ET,
  "7:30 PM ET": Status.THE_730_PM_ET,
  "8:00 PM ET": Status.THE_800_PM_ET,
  "8:30 PM ET": Status.THE_830_PM_ET,
  "9:00 PM ET": Status.THE_900_PM_ET
});

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
