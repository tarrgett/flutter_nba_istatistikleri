import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_nba/model/nbaOyuncuIstatistikleri.dart';
import 'package:http/http.dart' as http;

import 'advertService.dart';

class OyuncuDetail extends StatefulWidget {
  String oyuncuName;
  String oyuncuID;
  OyuncuDetail({
    Key key,
    @required this.oyuncuName,
    @required this.oyuncuID,
  }) : super(key: key);
  @override
  _OyuncuDetailState createState() => _OyuncuDetailState();
}

class _OyuncuDetailState extends State<OyuncuDetail> {
  AdvertService _advertService = AdvertService();
  String sezon = "2020";
  NbaOyuncuIstatistikleri oyuncuDetayListesi;
  Future<NbaOyuncuIstatistikleri> oyuncuIstatistikleri() async {
    var oyuncular = await http.get("https://www.balldontlie"
            ".io/api/v1/season_averages?season=" +
        sezon +
        "&player_ids[]=" +
        widget.oyuncuID);
    var oyuncularDecodedJson = await json.decode(oyuncular.body);
    oyuncuDetayListesi = NbaOyuncuIstatistikleri.fromJson(oyuncularDecodedJson);
    return oyuncuDetayListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.oyuncuName),
      ),
      body: FutureBuilder(
        future: oyuncuIstatistikleri(),
        builder: (context, AsyncSnapshot<NbaOyuncuIstatistikleri> gelenDetay) {
          if (gelenDetay.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (gelenDetay.connectionState == ConnectionState.done) {
            return istatistikler(gelenDetay);
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

  Widget istatistikler(AsyncSnapshot<NbaOyuncuIstatistikleri> gelenDetay) {
    try {
      return SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Sezon : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.season.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Oynadığı Maçlar : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.gamesPlayed.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Oynadığı Süre : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.min.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Şut İsabeti : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fgm.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Attığı Şut : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fga.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Üçlü Atışları : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fg3A.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "İsabetli Üçlük Atışları : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fg3M.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Faul Şut Atışı : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.ftm.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Faul Şut İsabeti : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fga.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Ofansif Ribaund : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.oreb.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Defansif Ribaund : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.dreb.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Asist : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.ast.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Çaldığı Top : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.stl.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Blok : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.blk.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Kaybedilen Top : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.turnover.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Yapılan Faul : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.pf.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Attığı Sayı : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.pts.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Şut Başarı Yüzdesi : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fgPct.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Başarılı Üçlük Yüzdesi : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.fg3Pct.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Başarı Serbest Atış Yüzdesi : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                            Text(
                              gelenDetay.data.data.first.ftPct.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 70),
                    width: MediaQuery.of(context).size.width / 2,
                    child: FlatButton(
                      color: Colors.blueGrey,
                      onPressed: () {
                        _advertService.showIntersitial();
                        sezon =
                            (gelenDetay.data.data.first.season - 1).toString();
                        setState(() {});
                      },
                      child: Text("Önceki Sezon"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 70),
                    width: MediaQuery.of(context).size.width / 2,
                    child: FlatButton(
                      color: Colors.blueGrey,
                      onPressed: () {
                        sezon = "2020";
                        setState(() {});
                      },
                      child: Text("Güncel Sezon"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "$sezon Sezonu Oyuncu İstatistikleri Bulunamadı.",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FlatButton(
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (context) => SezonDegistir()))
                      .then((pop) {
                    sezon = pop;
                    setState(() {});
                  });
                },
                child: Text("Sezon Değiştir"),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class SezonDegistir extends StatefulWidget {
  @override
  _SezonDegistirState createState() => _SezonDegistirState();
}

class _SezonDegistirState extends State<SezonDegistir> {
  AdvertService _advertService = AdvertService();
  final formKey = GlobalKey<FormState>();
  String sezon = "2020";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Sezon Değiştir"),
      ),
      body: Form(
        key: formKey,
        autovalidate: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: TextFormField(
                      autofocus: true,
                      onSaved: (String girilenDeger) {
                        sezon = girilenDeger;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Sezon",
                          hintText: "Sezon",
                          prefixIcon: Icon(Icons.sports_basketball),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        _advertService.showIntersitial();
                        formKey.currentState.save();
                        if (sezon == null) {
                          Navigator.pop(context, "2020");
                        } else {
                          Navigator.pop(context, sezon);
                        }
                      },
                      child: Text("Sezona Git"),
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Image.network(
                      "https://trendbasket"
                      ".net/wp-content/uploads/2016/03/NBA-Logo.jpg",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
