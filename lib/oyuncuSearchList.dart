import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nba/oyuncuDetail.dart';
import 'package:http/http.dart' as http;
import 'advertService.dart';
import 'model/nbaOyunculari.dart';

class OyuncuSearchList extends StatefulWidget {
  String oyuncuName;
  OyuncuSearchList({
    Key key,
    @required this.oyuncuName,
  }) : super(key: key);
  @override
  _OyuncuSearchListState createState() => _OyuncuSearchListState();
}

class _OyuncuSearchListState extends State<OyuncuSearchList> {
  AdvertService _advertService = AdvertService();
  NbaOyunculari oyuncuListesi;
  Future<NbaOyunculari> nbaOyunculari() async {
    var oyuncular = await http.get("https://www.balldontlie"
            ".io/api/v1/players?search=" +
        widget.oyuncuName);
    var oyuncularDecodedJson = await json.decode(oyuncular.body);
    oyuncuListesi = NbaOyunculari.fromJson(oyuncularDecodedJson);
    return oyuncuListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('"' + widget.oyuncuName + '"' + " Arama Sonuçları"),
      ),
      body: FutureBuilder(
        future: nbaOyunculari(),
        builder: (context, AsyncSnapshot<NbaOyunculari> gelenOyuncular) {
          if (gelenOyuncular.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (gelenOyuncular.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 150,
                  child: ListView.builder(
                      itemCount: gelenOyuncular.data.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              gelenOyuncular.data.data[index].firstName +
                                  " " +
                                  gelenOyuncular.data.data[index].lastName),
                          subtitle: Text(
                              gelenOyuncular.data.data[index].team.fullName),
                          leading: Icon(Icons.sports_basketball),
                          trailing:
                              Text(gelenOyuncular.data.data[index].position),
                          onTap: () {
                            _advertService.showIntersitial();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => OyuncuDetail(
                                      oyuncuID: gelenOyuncular
                                          .data.data[index].id
                                          .toString(),
                                      oyuncuName: gelenOyuncular
                                              .data.data[index].firstName +
                                          " " +
                                          gelenOyuncular
                                              .data.data[index].lastName,
                                    )));
                          },
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Oyuncular Listesi getirilirken bir "
                  "hata oluştu İnternet bağlantınızı kontrol ederek tekrar "
                  "deneyiniz lütfen."),
            );
          }
        },
      ),
    );
  }
}
