import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;
import 'package:stok_takip_uygulamasi/islemTanim.dart';
import 'package:stok_takip_uygulamasi/urunGrid.dart';
import 'package:stok_takip_uygulamasi/urunTanim.dart';

import 'DrawerMenu.dart';
import 'model/BaseCategory.dart';

class Test extends StatefulWidget {
  final String islemTuru;
  final String islemAdi;
  final String islemAciklamasi;
  final String islemTarihi;
  final int anaDepo;
  final int hedefDepo;

  const Test({Key? key,
    required this.islemTuru,
    required this.islemAdi,
    required this.islemAciklamasi,
    required this.anaDepo,
    required this.hedefDepo,
    required this.islemTarihi})
      : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  bool _isButtonDisabled = true;
  var urunhk;
  var urun1;
  var urun2;
  var urun3;
  var urun4;
  var urun5;
  late String urunhks;
  late String urun1s;
  late String urun2s;
  late String urun3s;
  late String urun4s;
  late String urun5s;

  @override
  initState() {
    super.initState();
    baseCategoryListele();
    _isButtonDisabled = true;
    setState(() {});
  }

  //region baseCategory
  List<Data> baseCategory = <Data>[];
  var tfTifList = TextEditingController();

  Future<List<Data>> baseCategoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
    baseCategory = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    if (baseCategory.isEmpty) {
      _isButtonDisabled = false;
      setState(() {});
    } else {
      _isButtonDisabled = true;
      setState(() {});
    }
    return baseCategory;
  }

  //endregion

  //region duzey1
  List<Data> duzey1 = <Data>[];

  Future<List<Data>> duzey1Listele(int ParentIdFilter) async {
    print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));


    duzey1 = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    if (duzey1.isEmpty) {
      _isButtonDisabled = false;
      print('11');
      getSelected(urunhks,"","","","","");
      setState(() {});
    } else {
      print('DUZEY 1');
      print(duzey1);
      print((int.parse(((((urunhk.replaceAll('[', '')).replaceAll(']', ''))
          .replaceAll('<', ''))
          .replaceAll('>', ''))
          .replaceAll("'", ''))).runtimeType);

      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey1;
  }

  //endregion

  //region duzey2
  List<Data> duzey2 = <Data>[];

  Future<List<Data>> duzey2Listele(int ParentIdFilter) async {
    setState(() {});
    print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey2 = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    // print("duzey son: ${duzey2[].malzemeAdi}");
    if (duzey2.isEmpty) {
      print('22');
      getSelected(urunhks,urun1s,"","","","","");

      _isButtonDisabled = false;
      setState(() {});
    } else {
      print('DUZEY 2');
      print(duzey2);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey2;
  }

  List<Data> selected = <Data>[];

  var sonuc;
  Future<List<Data>> getSelected(String HesapKoduFilter,[String? Duzey1Filter,
    String? Duzey2Filter, String? Duzey3Filter, String? Duzey4Filter, String? Duzey5Filter, String? ParentIdFilter]
     ) async {
    setState(() {});
    print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?HesapKoduFilter=${HesapKoduFilter}&Duzey1Filter=${Duzey1Filter}&Duzey2Filter=${Duzey2Filter}&Duzey3Filter=${Duzey3Filter}&Duzey4Filter=${Duzey4Filter}&Duzey5Filter=${Duzey5Filter}&ParentIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));

    print(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?HesapKoduFilter=${HesapKoduFilter}&Duzey1Filter=${Duzey1Filter}&Duzey2Filter=${Duzey2Filter}&Duzey3Filter=${Duzey3Filter}&Duzey4Filter=${Duzey4Filter}&Duzey5Filter=${Duzey5Filter}&ParentIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false');
    print(res.body);
    selected = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    sonuc = selected[0].malzemeAdi;
    print("duzey son: ${selected[0].malzemeAdi}");

    return selected;
  }

  //endregion

  //region duzey3
  List<Data> duzey3 = <Data>[];

  Future<List<Data>> duzey3Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey3 = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();


    if (duzey3.isEmpty) {
      print('33');
      getSelected(urunhks,urun1s,urun2s,"","","","");

      _isButtonDisabled = false;
      setState(() {});
    } else {
      print('DUZEY 3');
      print(duzey3);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey3;
  }

  //endregion

  //region duzey4
  List<Data> duzey4 = <Data>[];

  Future<List<Data>> duzey4Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey4 = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    if (duzey4.isEmpty) {
      print('44');
      getSelected(urunhks,urun1s,urun2s,urun3s,"","","");
      _isButtonDisabled = false;
      setState(() {});
    } else {
      print('DUZEY 4');
      print(duzey4);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey4;
  }

  //endregion

  //region duzey5
  List<Data> duzey5 = <Data>[];

  Future<List<Data>> duzey5Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey5 = BaseCategory
        .fromJson(json.decode(res.body))
        .data
        .toList();

    if (duzey5.isEmpty) {
      print('55');
      getSelected(urunhks,urun1s,urun2s,urun3s,urun4s,"","");
       _isButtonDisabled = false;
      setState(() {});
    } else {
      print('DUZEY 5');
      print(duzey5);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey5;
  }

  //endregion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Color(0xFF976775),
          title: Text('İŞLEM TANIM',
              style: GoogleFonts.notoSansTaiLe(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              )),
        ),
        endDrawer: DrawerMenu(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  Text('Lütfen ürün seçimi veya barkod ile tarama yapınız.',
                      style: GoogleFonts.notoSansTaiLe(
                        fontSize: 15,
                        color: Color(0XFF976775),
                      )),

                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Hesap Kodu Seçiniz',
                    suggestions: baseCategory
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.hesapKodu.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.malzemeAdi.toString(),
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52))),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urunhks = e.searchKey;
                      print("hk: ${urunhk}");
                      setState(() {
                        // print(e.key);
                        // print("urun: ${urun}");
                        urunhk = e.key.toString();
                        print("hk: ${urunhk}");
                      });
                      // print( ((((urun.replaceAll('[', '')).replaceAll(']', ''))
                      //     .replaceAll('<', ''))
                      //     .replaceAll('>', ''))
                      //     .replaceAll("'", ''));
                      duzey1Listele(int.parse(
                          ((((urunhk.replaceAll('[', '')).replaceAll(']', ''))
                              .replaceAll('<', ''))
                              .replaceAll('>', ''))
                              .replaceAll("'", '')));

                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Düzey 1 Seçiniz',
                    suggestions: duzey1
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.duzey1.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.5,
                                    child: Text(e.malzemeAdi.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urun1s = e.searchKey;
                      setState(() {
                        // print(e.key);
                        // print("urun1: ${urun1}");
                        urun1 = e.key.toString();
                      });
                      // print(urun1);
                      print(((((urun1.replaceAll('[', '')).replaceAll(']', ''))
                          .replaceAll('<', ''))
                          .replaceAll('>', ''))
                          .replaceAll("'", ''));
                      duzey2Listele(int.parse(
                          ((((urun1.replaceAll('[', '')).replaceAll(']', ''))
                              .replaceAll('<', ''))
                              .replaceAll('>', ''))
                              .replaceAll("'", '')));
                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Düzey 2 Seçiniz',
                    suggestions: duzey2
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.duzey2.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.5,
                                    child: Text(e.malzemeAdi.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urun2s = e.searchKey;
                      setState(() {
                        // print(e.key);
                        // print("urun2: ${urun2}");
                        urun2 = e.key.toString();
                      });

                      // print(urun2);
                      // print( ((((urun2.replaceAll('[', '')).replaceAll(']', ''))
                      //     .replaceAll('<', ''))
                      //     .replaceAll('>', ''))
                      //     .replaceAll("'", ''));
                      duzey3Listele(int.parse(
                          ((((urun2.replaceAll('[', '')).replaceAll(']', ''))
                              .replaceAll('<', ''))
                              .replaceAll('>', ''))
                              .replaceAll("'", '')));
                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Düzey 3 Seçiniz',
                    suggestions: duzey3
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.duzey3.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.5,
                                    child: Text(e.malzemeAdi.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urun3s = e.searchKey;
                      setState(() {
                        // print(e.key);
                        // print("urun3: ${urun3}");
                        urun3 = e.key.toString();
                      });
                      // print(urun3);
                      // print( ((((urun3.replaceAll('[', '')).replaceAll(']', ''))
                      //     .replaceAll('<', ''))
                      //     .replaceAll('>', ''))
                      //     .replaceAll("'", ''));
                      duzey4Listele(int.parse(
                          ((((urun3.replaceAll('[', '')).replaceAll(']', ''))
                              .replaceAll('<', ''))
                              .replaceAll('>', ''))
                              .replaceAll("'", '')));
                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Düzey 4 Seçiniz',
                    suggestions: duzey4
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.duzey4.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.5,
                                    child: Text(e.malzemeAdi.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urun4s = e.searchKey;
                      setState(() {
                        // print(e.key);
                        // print("urun4: ${urun4}");
                        urun4 = e.key.toString();
                      });
                      duzey5Listele(int.parse(
                          ((((urun4.replaceAll('[', '')).replaceAll(']', ''))
                              .replaceAll('<', ''))
                              .replaceAll('>', ''))
                              .replaceAll("'", '')));
                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SearchField<String>(
                    hint: 'Düzey 5 Seçiniz',
                    suggestions: duzey5
                        .map(
                          (e) =>
                          SearchFieldListItem<String>(e.duzey5.toString(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 1.5,
                                    child: Text(e.malzemeAdi.toString(),
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(
                                            color: Color(0XFF6E3F52),
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              key: Key(e.id.toString())),
                    )
                        .toList(),
                    onSuggestionTap: (e) {
                      urun5s = e.searchKey;
                      setState(() {
                        // print(e.key);
                        // print("urun5: ${urun5}");
                        urun5 = e.key.toString();
                      });
                      // print(urun5);
                      // print( ((((urun5.replaceAll('[', '')).replaceAll(']', ''))
                      //     .replaceAll('<', ''))
                      //     .replaceAll('>', ''))
                      //     .replaceAll("'", ''));
                      // duzey5Listele(int.parse(((((urun5.replaceAll('[', '')).replaceAll(']', ''))
                      //     .replaceAll('<', ''))
                      //     .replaceAll('>', ''))
                      //     .replaceAll("'", '')));
                      print('Bitti');
                      setState(() {});
                    },
                    suggestionAction: SuggestionAction.unfocus,
                    itemHeight: 50,
                    searchStyle: TextStyle(color: Color(0XFF976775)),
                    suggestionStyle: TextStyle(color: Color(0XFF976775)),
                    // suggestionsDecoration: BoxDecoration(color: Colors.red),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Color(0XFF463848),
                      side: BorderSide(width: 1.0, color: Color(0XFF463848)),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> urunGrid()));
                      setState(() {});
                    },
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>IslemTanim()));
                      },
                      child: Text(_isButtonDisabled ? "Hold on..." : "SEÇ",
                          style: TextStyle(
                              color: Color(0XFFDBDCE8),
                              fontSize: 15,
                              letterSpacing: 2.0)),
                    ),
                  )
                ]),
              )),
        ));
    // return AwesomeDialog(
    //   context: context,
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "İşlem Türü: ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.islemTuru}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "İşlem Adı: ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.islemAdi}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "İşlem Açıklaması: ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.islemAciklamasi}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "İşlem Tarihi: ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.islemTarihi}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "Ana Depo:  ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.anaDepo}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //       Row(
    //         children: [
    //           Text(
    //             "Hedef Depo:  ",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           Text(" ${this.widget.hedefDepo}"),
    //         ],
    //       ),
    //       SizedBox(
    //         height: 15,
    //       ),
    //     ],
    //   ),
    //   dialogType: DialogType.noHeader,
    //   borderSide: const BorderSide(
    //     color: Color(0XFF6E3F52),
    //     width: 2,
    //   ),
    //   width: MediaQuery.of(context).size.width,
    //   buttonsBorderRadius: const BorderRadius.all(
    //     Radius.circular(2),
    //   ),
    //   dismissOnTouchOutside: true,
    //   dismissOnBackKeyPress: false,
    //   headerAnimationLoop: false,
    //   animType: AnimType.bottomSlide,
    //   showCloseIcon: true,
    // ).show();
  }
}
