import 'package:flutter/material.dart';
import 'package:flutter_nba/advertService.dart';
import 'package:flutter_nba/model/nbaOyunculari.dart';
import 'package:flutter_nba/oyuncuDetail.dart';
import 'package:flutter_nba/oyuncuSearch.dart';
import 'package:flutter_nba/sezonMaclari.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdvertService _advertService = AdvertService();
  String page = "1";
  NbaOyunculari oyuncuListesi;
  Datum donenOyuncular;
  Future<NbaOyunculari> nbaOyunculari() async {
    var oyuncular = await http.get("https://www.balldontlie"
            ".io/api/v1/players?per_page=100&page=" +
        page);
    var oyuncularDecodedJson = await json.decode(oyuncular.body);
    oyuncuListesi = NbaOyunculari.fromJson(oyuncularDecodedJson);
    return oyuncuListesi;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _advertService.showBanner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(
            child: Text("Nba"),
          ),
          leading: IconButton(
            icon: Icon(Icons.sports),
            onPressed: () {
              _advertService.showIntersitial();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SezonMaclari()));
            },
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => OyuncuSearch()));
                })
          ],
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
                    height: MediaQuery.of(context).size.height - 170,
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
                                      oyuncuName: gelenOyuncular
                                              .data.data[index].firstName +
                                          " " +
                                          gelenOyuncular
                                              .data.data[index].lastName,
                                      oyuncuID: gelenOyuncular
                                          .data.data[index].id
                                          .toString())));
                            },
                          );
                        }),
                  ),
                  sayfalama(gelenOyuncular),
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
        ));
  }

  sayfalama(AsyncSnapshot<NbaOyunculari> gelenOyuncular) {
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
