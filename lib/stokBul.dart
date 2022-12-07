import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/Envanter.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';

class stokBul extends StatefulWidget {
  const stokBul({Key? key}) : super(key: key);

  @override
  State<stokBul> createState() => _stokBulState();
}

class _stokBulState extends State<stokBul> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> liste = ['e','3'];
    var varyant;
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Color(0XFF976775),

          title: Text('Stok Bul')
        ),
        endDrawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: const Color(0XFF6E3F52)),
                child: Text(' '),
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'TANIMLAMALAR',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tanimlamalar()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'İŞLEM TASLAKLARI',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => IsTaslak()));              },
              ),
              ListTile(
                leading: Icon(
                  Icons.description,
                  color: Color(0XFF976775),
                ),
                title: const Text(
                  'ONAY İŞLEMLERİ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF976775)),
                ),
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => IsTaslak()));
                },
              ),
            ],
          ),
        ),
        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchField<String>(
            hint: 'Ürün Ara',

            onSuggestionTap: (e) {
              varyant = e.searchKey;

              setState(() {
                varyant = e.key.toString();
                //detay getir apisi çalışacak widget ın içine basacak.
              });
            },
            suggestionAction: SuggestionAction.unfocus,
            itemHeight: 50,
            searchStyle: TextStyle(color: Color(0XFF976775)),
            suggestionStyle: TextStyle(color: Color(0XFF976775)),
            // suggestionsDecoration: BoxDecoration(color: Colors.red),
            suggestions: liste
                .map(
                  (e) => SearchFieldListItem<String>(e.toString(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e.toString(),
                            style: TextStyle(color: Color(0XFF6E3F52))),
                      ),
                    ],
                  ),
                  key: Key(e.toString())),
            )
                .toList(),
          ),
        ),

        // ListView(
        //   padding: const EdgeInsets.all(8),
        //   children: <Widget>[
        //     Container(
        //       height: 50,
        //       color: Color(0XFFDBDCE8),
        //       child: Row(
        //         children: [
        //           Image.network(
        //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adı: TV',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adedi: 23',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //     Divider(),
        //     Container(
        //       height: 50,
        //       color: Color(0XFFDBDCE8),
        //       child: Row(
        //         children: [
        //           Image.network(
        //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adı: TV',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adedi: 23',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //     Divider(),
        //     Container(
        //       height: 50,
        //       color: Color(0XFFDBDCE8),
        //       child: Row(
        //         children: [
        //           Image.network(
        //               'https://www.bahcelievler.istanbul/style/images/favicon.png'),
        //           Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adı: TV',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               Padding(
        //                 padding: const EdgeInsets.all(3.0),
        //                 child: Text(
        //                   'Ürün Adedi: 23',
        //                   style: TextStyle(
        //                       color: Color(0XFF976775),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //             ],
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // )

    );
  }
}
