import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Color(0XFF976775),

          title: TextField(
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
            controller: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.redAccent),
              ),
                hintText: 'Ara', hintStyle: TextStyle(color: Colors.white60)),
          ),
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
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Container(
              height: 50,
              color: Color(0XFFDBDCE8),
              child: Row(
                children: [
                  Image.network(
                      'https://www.bahcelievler.istanbul/style/images/favicon.png'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adı: TV',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adedi: 23',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              height: 50,
              color: Color(0XFFDBDCE8),
              child: Row(
                children: [
                  Image.network(
                      'https://www.bahcelievler.istanbul/style/images/favicon.png'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adı: TV',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adedi: 23',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Container(
              height: 50,
              color: Color(0XFFDBDCE8),
              child: Row(
                children: [
                  Image.network(
                      'https://www.bahcelievler.istanbul/style/images/favicon.png'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adı: TV',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Ürün Adedi: 23',
                          style: TextStyle(
                              color: Color(0XFF976775),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
