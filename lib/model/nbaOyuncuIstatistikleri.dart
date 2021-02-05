// To parse this JSON data, do
//
//     final nbaOyuncuIstatistikleri = nbaOyuncuIstatistikleriFromJson(jsonString);

import 'dart:convert';

NbaOyuncuIstatistikleri nbaOyuncuIstatistikleriFromJson(String str) =>
    NbaOyuncuIstatistikleri.fromJson(json.decode(str));

String nbaOyuncuIstatistikleriToJson(NbaOyuncuIstatistikleri data) =>
    json.encode(data.toJson());

class NbaOyuncuIstatistikleri {
  NbaOyuncuIstatistikleri({
    this.data,
  });

  List<Datum> data;

  factory NbaOyuncuIstatistikleri.fromJson(Map<String, dynamic> json) =>
      NbaOyuncuIstatistikleri(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.gamesPlayed,
    this.playerId,
    this.season,
    this.min,
    this.fgm,
    this.fga,
    this.fg3M,
    this.fg3A,
    this.ftm,
    this.fta,
    this.oreb,
    this.dreb,
    this.reb,
    this.ast,
    this.stl,
    this.blk,
    this.turnover,
    this.pf,
    this.pts,
    this.fgPct,
    this.fg3Pct,
    this.ftPct,
  });

  int gamesPlayed;
  int playerId;
  int season;
  String min;
  double fgm;
  double fga;
  double fg3M;
  double fg3A;
  double ftm;
  double fta;
  double oreb;
  double dreb;
  double reb;
  double ast;
  double stl;
  double blk;
  double turnover;
  double pf;
  double pts;
  double fgPct;
  double fg3Pct;
  double ftPct;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        gamesPlayed: json["games_played"],
        playerId: json["player_id"],
        season: json["season"],
        min: json["min"],
        fgm: json["fgm"].toDouble(),
        fga: json["fga"].toDouble(),
        fg3M: json["fg3m"].toDouble(),
        fg3A: json["fg3a"].toDouble(),
        ftm: json["ftm"].toDouble(),
        fta: json["fta"].toDouble(),
        oreb: json["oreb"].toDouble(),
        dreb: json["dreb"].toDouble(),
        reb: json["reb"].toDouble(),
        ast: json["ast"].toDouble(),
        stl: json["stl"].toDouble(),
        blk: json["blk"].toDouble(),
        turnover: json["turnover"].toDouble(),
        pf: json["pf"].toDouble(),
        pts: json["pts"].toDouble(),
        fgPct: json["fg_pct"].toDouble(),
        fg3Pct: json["fg3_pct"].toDouble(),
        ftPct: json["ft_pct"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "games_played": gamesPlayed,
        "player_id": playerId,
        "season": season,
        "min": min,
        "fgm": fgm,
        "fga": fga,
        "fg3m": fg3M,
        "fg3a": fg3A,
        "ftm": ftm,
        "fta": fta,
        "oreb": oreb,
        "dreb": dreb,
        "reb": reb,
        "ast": ast,
        "stl": stl,
        "blk": blk,
        "turnover": turnover,
        "pf": pf,
        "pts": pts,
        "fg_pct": fgPct,
        "fg3_pct": fg3Pct,
        "ft_pct": ftPct,
      };
}
