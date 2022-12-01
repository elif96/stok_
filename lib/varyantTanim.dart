import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stok_takip_uygulamasi/isTaslak.dart';
import 'package:stok_takip_uygulamasi/tanimlamalar.dart';
import 'package:http/http.dart' as http;

class VaryantTanim extends StatefulWidget {
  const VaryantTanim({Key? key}) : super(key: key);

  @override
  State<VaryantTanim> createState() => _VaryantTanimState();
}



class _VaryantTanimState extends State<VaryantTanim> {

  Future<void> varyantEkle(String varyantAdi) async {
    var url = Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Variants');
    http.Response response = await http.post(url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: json.encoder.convert({
          "varyantAdi": varyantAdi
        }));
    varyantAdi = "";

    print(response.body);
    print(response.statusCode);
    print(response.reasonPhrase);

    if(tfVaryantAdi.text ==""){
      //silinecek marka bulunamadı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Lütfen varyant adı girin."),
        backgroundColor: Colors.red,
      ));
      tfVaryantAdi.clear();
      setState(() {});
    }
    else if(response.reasonPhrase == 'Bad Request'){
      //model olduğu için marka silinemedi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Eklemek istediğiniz varyant zaten var."),
        backgroundColor: Colors.red,
      ));
      tfVaryantAdi.clear();
      setState(() {});
    }
    else if(response.reasonPhrase == 'Created'){
      // başarılı
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Varyant ekleme işlemi başarıyla gerçekleştirildi."),
        backgroundColor: Colors.green,
      ));
      tfVaryantAdi.clear();
      setState(() {});
    }

  }

  var tfVaryantAdi = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFF976775), title: Text('Varyant Tanım')),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: tfVaryantAdi,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.view_in_ar,
                        color: Color(0XFF6E3F52),
                      ),
                      hintStyle: TextStyle(color: Color(0XFF976775)),
                      hintText: "Varyant Adı",
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
                        varyantEkle(tfVaryantAdi.text);


                      },
                      child: (Text(
                        'VARYANT EKLE',
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
