import 'package:flutter/material.dart';
import 'package:flutter_nba/advertService.dart';
import 'package:flutter_nba/oyuncuSearchList.dart';

class OyuncuSearch extends StatefulWidget {
  @override
  _OyuncuSearchState createState() => _OyuncuSearchState();
}

class _OyuncuSearchState extends State<OyuncuSearch> {
  AdvertService _advertService = AdvertService();
  var oyuncuName;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Search"),
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
                      onSaved: (String girilenDeger) {
                        oyuncuName = girilenDeger;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Oyuncu İsmi",
                          hintText: "Oyuncu İsmi",
                          prefixIcon: Icon(Icons.account_circle),
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
                        Navigator.pop(context);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                OyuncuSearchList(oyuncuName: oyuncuName)));
                      },
                      child: Text("Oyuncuyu Ara"),
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
