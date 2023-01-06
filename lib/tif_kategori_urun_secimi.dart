import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:stok_takip_uygulamasi/drawer_menu.dart';
import 'package:stok_takip_uygulamasi/model/Category.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/tif_listesi.dart';
import 'package:stok_takip_uygulamasi/varyant_secimi.dart';

import 'model/BaseCategory.dart';
import 'package:http/http.dart' as http;

class TifKategoriUrunSecimi extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final myData<BaseCategory>? sonuc;
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
var kategori = 'sdfsdf';
var urunler = 'asdasd';

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

  late myData<BaseCategory> baseCategory = myData<BaseCategory>();

  Future<myData<BaseCategory>> baseCategoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
    baseCategory = myData<BaseCategory>.fromJson(
        json.decode(res.body), BaseCategory.fromJsonModel);

    return baseCategory;
  }

  late myData<Category> category = myData<Category>();

  // Future<myData<Category>> categoryListele(
  //     int BrandIdFilter,
  //     int BrandModelIdFilter,
  //     int BaseCategoryIdFilter,
  //     int Id,
  //     int Page,
  //     int PageSize,
  //     String Orderby,
  //     bool Desc,
  //     bool isDeleted,
  //     bool includeParents,
  //     bool includeChildren) async {
  Future<myData<Category>> categoryListele(
 ) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/Categories/GetAll?BrandIdFilter=0&BrandModelIdFilter=0&BaseCategoryIdFilter=19&Id=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false&includeParents=true&includeChildren=false'));
    print(res.body);
    // print(
    //     'https://stok.bahcelievler.bel.tr/api/Categories/GetAll?BrandIdFilter=$BrandIdFilter&BrandModelIdFilter=$BrandModelIdFilter&BaseCategoryIdFilter=$BaseCategoryIdFilter&Id=$Id&Page=$Page&PageSize=$PageSize&Orderby=$Orderby&Desc=$Desc&isDeleted=$isDeleted&includeParents=$includeParents&includeChildren=$includeChildren');
    category = myData<Category>.fromJson(
        json.decode(res.body), Category.fromJsonModel);

    print(category.data);
    return category;
  }

  var dropdownvalue;
  int pageSize = 5;

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
                    hintText: tfTif.text == "" ? "TİF Listesi" : tfTif.text,
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
                FutureBuilder<myData<BaseCategory>>(
                  future: baseCategoryListele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
                          return SearchField<myData<BaseCategory>>(
                            autoCorrect: true,
                            hint: 'Kategori Seçiniz',
                            onSuggestionTap: (e) {
                              dropdownvalue = e.searchKey;
                              setState(() {
                                dropdownvalue = e.key.toString();
                              });
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data!.data!
                                .map(
                                  (e) => SearchFieldListItem<
                                          myData<BaseCategory>>(e.id.toString(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.id.toString(),
                                                style: const TextStyle(
                                                    color: Color(0XFF6E3F52))),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: const Text('Load More'),
                                                onTap: () {
                                                  // pageNum +=1;
                                                  print("e: ${e.id}");

                                                  pageSize += 5;

                                                  setState(() {});
                                                },
                                              ),
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.delete_outline,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  // varyantElemanSil(e.id!);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.border_color_outlined,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  // showGuncellemeDialog(e.id!);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      key: Key(e.id.toString())),
                                )
                                .toList(),
                          );
                        },
                      );
                    } else if (!(snapshot.hasError)) {
                      return SearchField(
                        suggestions: [],
                      ).emptyWidget;
                    }
                    return const CircularProgressIndicator(
                      color: Color(0XFF976775),
                    );
                  },
                ),
                FutureBuilder<myData<BaseCategory>>(
                  future: baseCategoryListele(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          // TfTest.addListener(() => markaListeleWithFilter(TfTest.text, 1, 2, 'Id', true));
                          return SearchField<myData<BaseCategory>>(
                            autoCorrect: true,
                            hint: 'Ürün Seçiniz',
                            onSuggestionTap: (e) {
                              dropdownvalue = e.searchKey;
                              setState(() {
                                dropdownvalue = e.key.toString();
                              });
                            },
                            suggestionAction: SuggestionAction.unfocus,
                            itemHeight: 50,
                            searchStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            suggestionStyle:
                                const TextStyle(color: Color(0XFF976775)),
                            // suggestionsDecoration: BoxDecoration(color: Colors.red),
                            suggestions: snapshot.data!.data!
                                .map(
                                  (e) => SearchFieldListItem<
                                          myData<BaseCategory>>(e.id.toString(),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(e.id.toString(),
                                                style: const TextStyle(
                                                    color: Color(0XFF6E3F52))),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: const Text('Load More'),
                                                onTap: () {
                                                  // pageNum +=1;
                                                  print("e: ${e.id}");

                                                  pageSize += 5;

                                                  setState(() {});
                                                },
                                              ),
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.delete_outline,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  // varyantElemanSil(e.id!);
                                                },
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                child: const Icon(
                                                  Icons.border_color_outlined,
                                                  color: Color(0XFF6E3F52),
                                                ),
                                                onTap: () {
                                                  // showGuncellemeDialog(e.id!);
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      key: Key(e.id.toString())),
                                )
                                .toList(),
                          );
                        },
                      );
                    } else if (!(snapshot.hasError)) {
                      return SearchField(
                        suggestions: [],
                      ).emptyWidget;
                    }
                    return const CircularProgressIndicator(
                      color: Color(0XFF976775),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                // SearchField<myData<BaseCategory>>(
                //   hint: 'Kategori Seçiniz',
                //
                //   onSuggestionTap: (e) {
                //     urun = e.searchKey;
                //
                //     setState(() {
                //       urun = e.key.toString();
                //     });
                //   },
                //   suggestionAction: SuggestionAction.unfocus,
                //   itemHeight: 50,
                //   searchStyle: const TextStyle(color: Color(0XFF976775)),
                //   suggestionStyle: const TextStyle(color: Color(0XFF976775)),
                //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
                //   suggestions: baseCategory.data!
                //       .map(
                //         (e) => SearchFieldListItem<myData<BaseCategory>>(
                //             e.toString(),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(e.hesapKodu.toString(),
                //                       style: const TextStyle(
                //                           color: Color(0XFF6E3F52))),
                //                 ),
                //               ],
                //             ),
                //             key: Key(e.toString())),
                //       )
                //       .toList(),
                // ),
                // SearchField<myData<BaseCategory>>(
                //   hint: 'Ürün Seçiniz',
                //
                //   onSuggestionTap: (e) {
                //     urun = e.searchKey;
                //
                //     setState(() {
                //       urun = e.key.toString();
                //     });
                //   },
                //   suggestionAction: SuggestionAction.unfocus,
                //   itemHeight: 50,
                //   searchStyle: const TextStyle(color: Color(0XFF976775)),
                //   suggestionStyle: const TextStyle(color: Color(0XFF976775)),
                //   // suggestionsDecoration: BoxDecoration(color: Colors.red),
                //   suggestions: baseCategory.data!
                //       .map(
                //         (e) => SearchFieldListItem<myData<BaseCategory>>(
                //             e.toString(),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Text(e.hesapKodu.toString(),
                //                       style: const TextStyle(
                //                           color: Color(0XFF6E3F52))),
                //                 ),
                //               ],
                //             ),
                //             key: Key(e.toString())),
                //       )
                //       .toList(),
                // ),
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
                          onPressed: () {
                            categoryListele();
                          })),
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
                              builder: (context) => VaryantSecimi()));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OnayaGonderGrid(
                      //             sonuc: this.widget.sonuc,
                      //             kategori: kategori,
                      //             urunler: urunler)));
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