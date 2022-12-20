import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/Servis.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';
import 'package:http/http.dart' as http;

class MarkaTanim extends StatefulWidget {
  const MarkaTanim({Key? key}) : super(key: key);

  @override
  State<MarkaTanim> createState() => _MarkaTanimState();
}

class _MarkaTanimState extends State<MarkaTanim> {
  var tfMarkaAdi = TextEditingController();

  Future<void> markaEkle() async {
    setState(() {});
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var data = sharedPreferences.getString('TesisId');

    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/brands');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "markaAdi": tfMarkaAdi.text
        }));
    tfMarkaAdi.text = "";

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201 ) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka kayıt işlemi başarılı."),
        backgroundColor: Colors.green,
      ));
      setState(() {});
    } else if(tfMarkaAdi.text == "" || tfMarkaAdi.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka kayıt işlemi gerçekleştirilemedi."),
        backgroundColor: Colors.red,
      ));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Marka kaydı oluşturulamadı."),
        backgroundColor: Colors.red,
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Marka Tanım')),
      endDrawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: tfMarkaAdi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.branding_watermark_outlined,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Marka Adı",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF6E3F52)))),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0XFF463848),
                        side: BorderSide(width: 1.0, color: Color(0XFF463848)),
                      ),
                      onPressed: () {
                        Servis().markaEkle(tfMarkaAdi.text);


                      },
                      child: (Text(
                        'MARKA EKLE',
                        style: TextStyle(color: Color(0XFFDBDCE8), fontSize: 15, letterSpacing: 2.0),
                      ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
