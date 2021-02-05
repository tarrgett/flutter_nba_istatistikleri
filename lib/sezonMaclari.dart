import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nba/model/nbaGames.dart';

class SezonMaclari extends StatefulWidget {
  @override
  _SezonMaclariState createState() => _SezonMaclariState();
}

class _SezonMaclariState extends State<SezonMaclari> {
  String page = "1";
  NbaGame macListesi;
  Future<NbaGame> nbaMaclari() async {
    var maclar = await http.get("https://www.balldontlie"
            ".io/api/v1/games?seasons[]=2020&per_page=100&page=" +
        page);
    var maclarDecodedJson = await json.decode(maclar.body);
    macListesi = NbaGame.fromJson(maclarDecodedJson);
    return macListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("2020-2021 Sezon Maçları"),
      ),
      body: FutureBuilder(
        future: nbaMaclari(),
        builder: (context, AsyncSnapshot<NbaGame> gelenMaclar) {
          if (gelenMaclar.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (gelenMaclar.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 170,
                  child: ListView.builder(
                      itemCount: gelenMaclar.data.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide()),
                          ),
                          child: ListTile(
                            title: Column(
                              children: [
                                Center(
                                  child: Text(
                                    gelenMaclar.data.data[index].date.day
                                            .toString() +
                                        "/" +
                                        gelenMaclar.data.data[index].date.month
                                            .toString() +
                                        "/" +
                                        gelenMaclar.data.data[index].date.year
                                            .toString(),
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    gelenMaclar.data.data[index].homeTeamScore >
                                            gelenMaclar.data.data[index]
                                                .visitorTeamScore
                                        ? Center(
                                            child: Text(
                                              gelenMaclar.data.data[index]
                                                      .homeTeam.name +
                                                  " - ",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              gelenMaclar.data.data[index]
                                                      .homeTeam.name +
                                                  " - ",
                                            ),
                                          ),
                                    gelenMaclar.data.data[index].homeTeamScore <
                                            gelenMaclar.data.data[index]
                                                .visitorTeamScore
                                        ? Center(
                                            child: Text(
                                                gelenMaclar.data.data[index]
                                                    .visitorTeam.name,
                                                style: TextStyle(
                                                    color: Colors.green)),
                                          )
                                        : Center(
                                            child: Text(gelenMaclar.data
                                                .data[index].visitorTeam.name),
                                          ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                            subtitle: Center(
                              child: Text(gelenMaclar
                                      .data.data[index].homeTeamScore
                                      .toString() +
                                  " - " +
                                  gelenMaclar.data.data[index].visitorTeamScore
                                      .toString()),
                            ),
                          ),
                        );
                      }),
                ),
                sayfalama(gelenMaclar),
              ],
            );
          } else {
            return Center(
              child: Text("Maç bilgileri getirilirken bir sorun "
                  "oluştu internet bağlantınızı kontrol ederek tekrar "
                  "deneyiniz."),
            );
          }
        },
      ),
    );
  }

  sayfalama(AsyncSnapshot<NbaGame> gelenOyuncular) {
    if (page != "1") {
      return Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            child: FlatButton(
              onPressed: () {
                page = (gelenOyuncular.data.meta.currentPage - 1).toString();
                setState(() {});
              },
              child: Text("Önceki Sayfa"),
            ),
          ),
          gelenOyuncular.data.meta.totalPages !=
                  gelenOyuncular.data.meta.currentPage
              ? Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FlatButton(
                    onPressed: () {
                      page = gelenOyuncular.data.meta.nextPage.toString();
                      setState(() {});
                    },
                    child: Text("Sonraki Sayfa"),
                  ),
                )
              : Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(""),
                  ),
                )
        ],
      );
    } else {
      if (gelenOyuncular.data.meta.totalPages !=
          gelenOyuncular.data.meta.currentPage) {
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  page = gelenOyuncular.data.meta.nextPage.toString();
                  setState(() {});
                },
                child: Text("Sonraki Sayfa"),
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                onPressed: () {
                  page = (gelenOyuncular.data.meta.currentPage - 1).toString();
                  setState(() {});
                },
                child: Text("Önceki Sayfa"),
              ),
            ),
          ],
        );
      }
    }
  }
}
