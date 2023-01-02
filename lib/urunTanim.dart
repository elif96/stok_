import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/DrawerMenu.dart';
import 'package:stok_takip_uygulamasi/Test.dart';

import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class urunTanim extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final String? sonuc;

  const urunTanim(
      {Key? key,   this.islemTuru,
        this.islemAdi,
        this.islemAciklamasi,
        this.anaDepo,
        this.hedefDepo,
        this.islemTarihi,
      this.sonuc})
      : super(key: key);
  @override
  State<urunTanim> createState() => _urunTanimState();
}
var urun;



class _urunTanimState extends State<urunTanim> {
  @override
  initState() {
    super.initState();
    baseCategoryListele();
    setState(() {});
    print("Sonuç: ${this.widget.sonuc}");
  }

  List<Data> baseCategory = <Data>[];

  Future<List<Data>> baseCategoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
    baseCategory = BaseCategory.fromJson(json.decode(res.body)).data.toList();

    return baseCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        primary: true,
        backgroundColor: Color(0xFF976775),
        title: Text('ÜRÜN TANIM',
            style: GoogleFonts.notoSansTaiLe(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
      endDrawer: DrawerMenu(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
                       Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> Test(islemTuru: this.widget.islemTuru.toString(), islemAdi: this.widget.islemAdi.toString(), islemAciklamasi: this.widget.islemAciklamasi.toString(), anaDepo: int.parse(this.widget.anaDepo.toString()), hedefDepo: int.parse(this.widget.hedefDepo.toString()), islemTarihi: this.widget.islemTarihi.toString())));
                      //   showUrunAra();
                    },
                    icon: Icon(Icons.search_sharp),
                    color: Color(0XFF976775),
                    iconSize: 24,
                  ),
                ],
              ),
              SearchField<String>(
                hint: 'Kategori Seçiniz',

                onSuggestionTap: (e) {
                  urun = e.searchKey;

                  setState(() {
                    urun = e.key.toString();
                  });
                },
                suggestionAction: SuggestionAction.unfocus,
                itemHeight: 50,
                searchStyle: TextStyle(color: Color(0XFF976775)),
                suggestionStyle: TextStyle(color: Color(0XFF976775)),
                // suggestionsDecoration: BoxDecoration(color: Colors.red),
                suggestions: baseCategory
                    .map(
                      (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                    .toList(),
              ),
              SizedBox(
                height: 40,
              ),
              SearchField<String>(
                hint: 'Ürün Seçiniz',

                onSuggestionTap: (e) {
                  urun = e.searchKey;

                  setState(() {
                    urun = e.key.toString();
                  });
                },
                suggestionAction: SuggestionAction.unfocus,
                itemHeight: 50,
                searchStyle: TextStyle(color: Color(0XFF976775)),
                suggestionStyle: TextStyle(color: Color(0XFF976775)),
                // suggestionsDecoration: BoxDecoration(color: Colors.red),
                suggestions: baseCategory
                    .map(
                      (e) => SearchFieldListItem<String>(e.toString(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.hesapKodu.toString(),
                                style: TextStyle(color: Color(0XFF6E3F52))),
                          ),
                        ],
                      ),
                      key: Key(e.toString())),
                )
                    .toList(),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topRight,

                child: Container(decoration: BoxDecoration(
                  border: Border.all(width: 2, color:Color(0XFF6E3F52) ),
                  color: Color(0XFF976775),
                  shape: BoxShape.rectangle,
                ),child: IconButton(icon: Icon(Icons.barcode_reader), color: Color(0XFF463848), onPressed: () {  })),

              ),
              SizedBox(
                height: 40,
              ),
              AnimatedButton(
                  color: Color(0XFF463848),
                  text: 'Seç',
                  pressEvent: () {

                    setState(() {});
                  })


            ],
          ),
        ),
      ),
    );
  }
}
