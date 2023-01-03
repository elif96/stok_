import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/onaya_gonder_grid.dart';
import 'package:stok_takip_uygulamasi/tif_listesi.dart';

import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class TifKategoriUrunSecimi extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final List<Data>? sonuc;
  final String? kategori;
  final String? urunler;

  const TifKategoriUrunSecimi(
      {Key? key,
      this.islemTuru,
      this.islemAdi,
      this.islemAciklamasi,
      this.anaDepo,
      this.hedefDepo,
      this.islemTarihi,
      this.sonuc,
      this.kategori,
      this.urunler})
      : super(key: key);

  @override
  State<TifKategoriUrunSecimi> createState() => _TifKategoriUrunSecimiState();
}

var urun;
var kategori ='sdfsdf';
var urunler ='asdasd';


class _TifKategoriUrunSecimiState extends State<TifKategoriUrunSecimi> {
  @override
  initState() {
    super.initState();
    baseCategoryListele();
    setState(() {});
    // print("Sonuç: ${this.widget.sonuc![0].malzemeAdi}");

    // tfTif.text = this.widget.sonuc![0].malzemeAdi == "" ?'TİF Listesi' : this.widget.sonuc![0].malzemeAdi.toString();
  }

  var tfTif = new TextEditingController();
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
        backgroundColor: const Color(0xFF976775),
        title: Text('TİF-KATEGORİ-ÜRÜN',
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: tfTif,
                  decoration: InputDecoration(
                    hintText: tfTif.text =="" ? "TİF Listesi": tfTif.text,
                    suffixIcon: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TifListesi(
                                    islemTuru: this.widget.islemTuru.toString(),
                                    islemAdi: this.widget.islemAdi.toString(),
                                    islemAciklamasi:
                                        this.widget.islemAciklamasi.toString(),
                                    anaDepo: int.parse(
                                        this.widget.anaDepo.toString()),
                                    hedefDepo: int.parse(
                                        this.widget.hedefDepo.toString()),
                                    islemTarihi:
                                        this.widget.islemTarihi.toString())));
                      },
                      icon: Icon(Icons.search_sharp),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                  searchStyle: const TextStyle(color: Color(0XFF976775)),
                  suggestionStyle: const TextStyle(color: Color(0XFF976775)),
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
                                      style: const TextStyle(
                                          color: Color(0XFF6E3F52))),
                                ),
                              ],
                            ),
                            key: Key(e.toString())),
                      )
                      .toList(),
                ),
                const SizedBox(
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
                  searchStyle: const TextStyle(color: Color(0XFF976775)),
                  suggestionStyle: const TextStyle(color: Color(0XFF976775)),
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
                                      style: const TextStyle(
                                          color: Color(0XFF6E3F52))),
                                ),
                              ],
                            ),
                            key: Key(e.toString())),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: const Color(0XFF6E3F52)),
                        color: const Color(0XFF976775),
                        shape: BoxShape.rectangle,
                      ),
                      child: IconButton(
                          icon: const Icon(Icons.barcode_reader),
                          color: const Color(0XFF463848),
                          onPressed: () {})),
                ),
                const SizedBox(
                  height: 40,
                ),
                AnimatedButton(
                    color: const Color(0XFF463848),
                    text: 'Seç',
                    pressEvent: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnayaGonderGrid(
                                  sonuc: this.widget.sonuc,
                                  kategori: kategori,
                                  urunler: urunler)));
                      setState(() {});
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
