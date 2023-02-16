import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchfield/searchfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stok_takip_uygulamasi/Islem_bilgileri.dart';
import 'package:stok_takip_uygulamasi/model/myData.dart';
import 'package:stok_takip_uygulamasi/myColors.dart';
import 'package:stok_takip_uygulamasi/onaya_gonder_grid.dart';
import 'package:stok_takip_uygulamasi/tif_kategori_urun_secimi.dart';
import 'drawer_menu.dart';
import 'model/BaseCategory.dart';

class TifListesi extends StatefulWidget {
  final String? islemTuru;
  final String? islemAdi;
  final String? islemAciklamasi;
  final String? islemTarihi;
  final int? anaDepo;
  final int? hedefDepo;
  final String? sonuc;
  final int? islemId;
  TifListesi({Key? key,
     this.islemTuru,
     this.islemAdi,
     this.islemAciklamasi,
     this.anaDepo,
     this.hedefDepo,
     this.islemTarihi, this.sonuc,this.islemId})
      : super(key: key);

  @override
  State<TifListesi> createState() => _TifListesiState();
}

class _TifListesiState extends State<TifListesi> {
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
    // setState(() {});

  }

  //region baseCategory
  myData<BaseCategory> baseCategory = myData<BaseCategory>();
  var tfTifList = TextEditingController();

  Future<myData<BaseCategory>> baseCategoryListele() async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?Page=1&PageSize=4&Orderby=Id&Desc=false&isDeleted=false'));
    baseCategory = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    if (baseCategory.data!.length == 0) {
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
  myData<BaseCategory> duzey1 = myData<BaseCategory>();

  Future<myData<BaseCategory>> duzey1Listele(int ParentIdFilter) async {
    // print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));


    duzey1 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    if (duzey1.data!.isEmpty) {
      _isButtonDisabled = false;

      getSelected(urunhks, "", "", "", "", "");
      setState(() {});
    } else {

      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey1;
  }

  //endregion

  //region duzey2
  myData<BaseCategory> duzey2 = myData<BaseCategory>();

  Future<myData<BaseCategory>> duzey2Listele(int ParentIdFilter) async {
    setState(() {});
    // print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey2 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    // print("duzey son: ${duzey2[].malzemeAdi}");
    if (duzey2.data!.length == 0) {
      getSelected(
          urunhks,
          urun1s,
          "",
          "",
          "",
          "",
          "");

      _isButtonDisabled = false;
      setState(() {});
    } else {
      // print('DUZEY 2');
      // print(duzey2);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey2;
  }

  late myData<BaseCategory> selected = myData<BaseCategory>();

  var sonuc;

  Future<myData<BaseCategory>> getSelected(String HesapKoduFilter, [String? Duzey1Filter,
    String? Duzey2Filter, String? Duzey3Filter, String? Duzey4Filter, String? Duzey5Filter, String? ParentIdFilter]) async {
    setState(() {});
    // print("parent id:${ParentIdFilter}");
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?HesapKoduFilter=${HesapKoduFilter}&Duzey1Filter=${Duzey1Filter}&Duzey2Filter=${Duzey2Filter}&Duzey3Filter=${Duzey3Filter}&Duzey4Filter=${Duzey4Filter}&Duzey5Filter=${Duzey5Filter}&ParentIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false'));

    // print(
    //     'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?HesapKoduFilter=${HesapKoduFilter}&Duzey1Filter=${Duzey1Filter}&Duzey2Filter=${Duzey2Filter}&Duzey3Filter=${Duzey3Filter}&Duzey4Filter=${Duzey4Filter}&Duzey5Filter=${Duzey5Filter}&ParentIdFilter=0&Page=1&PageSize=12&Orderby=Id&Desc=false&isDeleted=false');
    // print(res.body);
    selected = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    sonuc = selected.data![0].malzemeAdi;
    print(sonuc);

    // print("duzey son: ${selected.data![0].malzemeAdi}");
    // print("duzey son: ${selected.data![0].duzeyKodu}");
    // print("duzey son: ${selected.data![0].hesapKodu}");
    // print("duzey son: ${selected.data![0].id}");

    return selected;
  }

  //endregion

  //region duzey3
  myData<BaseCategory> duzey3 = myData<BaseCategory>();

  Future<myData<BaseCategory>> duzey3Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey3 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);



    if (duzey3.data!.length == 0) {
      getSelected(
          urunhks,
          urun1s,
          urun2s,
          "",
          "",
          "",
          "");

      _isButtonDisabled = false;
      setState(() {});
    } else {
      // print('DUZEY 3');
      // print(duzey3);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey3;
  }

  //endregion

  //region duzey4
  myData<BaseCategory> duzey4 = myData<BaseCategory>();

  Future<myData<BaseCategory>> duzey4Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey4 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    if (duzey4.data!.length == 0) {
      getSelected(
          urunhks,
          urun1s,
          urun2s,
          urun3s,
          "",
          "",
          "");
      _isButtonDisabled = false;
      setState(() {});
    } else {
      // print('DUZEY 4');
      // print(duzey4);
      _isButtonDisabled = true;
      setState(() {});
    }
    return duzey4;
  }

  //endregion

  //region duzey5
  myData<BaseCategory> duzey5 = myData<BaseCategory>();

  Future<myData<BaseCategory>> duzey5Listele(int ParentIdFilter) async {
    http.Response res = await http.get(Uri.parse(
        'https://stok.bahcelievler.bel.tr/api/BaseCategories/GetAll?ParentIdFilter=${ParentIdFilter}&Orderby=Id&Desc=false&isDeleted=false'));

    duzey5 = myData<BaseCategory>.fromJson(json.decode(res.body), BaseCategory.fromJsonModel);


    if (duzey5.data!.length == 0) {
      getSelected(
          urunhks,
          urun1s,
          urun2s,
          urun3s,
          urun4s,
          "",
          "");
      _isButtonDisabled = false;
      setState(() {});
    } else {
      // print('DUZEY 5');
      // print(duzey5);
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
          backgroundColor: myColors.topColor,
          title: Text('TİF LİSTESİ',
              style: GoogleFonts.raleway(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              )),
        ),
        endDrawer: DrawerMenu(),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(

              child: Column(children: [
                Text('Lütfen ürün seçimi yapınız.',
                    style: GoogleFonts.raleway(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: myColors.textColor,
                    )),

                const SizedBox(
                  height: 40,
                ),
                SearchField<myData<BaseCategory>>(
                  hint: 'Hesap Kodu Seçiniz',
                  suggestions:  baseCategory.data == null ? [] : baseCategory.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(
                            e.hesapKodu.toString(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(e.malzemeAdi.toString(),
                                      style: TextStyle(
                                          color: myColors.textColor, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
                  onSuggestionTap: (e) {
                    print(e.key.toString());
                    print(e.searchKey);
                    urunhks = e.searchKey;
                    // print("hk: ${urunhk}");
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
                  searchStyle: TextStyle(color: myColors.textColor),
                  suggestionStyle: TextStyle( color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                const SizedBox(
                  height: 40,
                ),

                SearchField<myData<BaseCategory>>(
                  hint: 'Düzey 1 Seçiniz',
                  suggestions:  duzey1.data == null ? [] : duzey1.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(e.duzey1.toString(),
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
                                          color: myColors.textColor, fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
                  onSuggestionTap: (e) {
                    urun1s = e.searchKey;
                    setState(() {
                      // print(e.key);
                      // print("urun1: ${urun1}");
                      urun1 = e.key.toString();
                    });
                    // print(urun1);
                    // print(((((urun1.replaceAll('[', '')).replaceAll(']', ''))
                    //     .replaceAll('<', ''))
                    //     .replaceAll('>', ''))
                    //     .replaceAll("'", ''));
                    duzey2Listele(int.parse(
                        ((((urun1.replaceAll('[', '')).replaceAll(']', ''))
                            .replaceAll('<', ''))
                            .replaceAll('>', ''))
                            .replaceAll("'", '')));
                    setState(() {});
                  },
                  suggestionAction: SuggestionAction.unfocus,
                  itemHeight: 50,
                  searchStyle: TextStyle( color: myColors.textColor),
                  suggestionStyle: TextStyle(color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                const SizedBox(
                  height: 40,
                ),
                SearchField<myData<BaseCategory>>(
                  hint: 'Düzey 2 Seçiniz',
                  suggestions:  duzey2.data == null ? [] : duzey2.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(e.duzey2.toString(),
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
                                          color: myColors.textColor, fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
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
                  searchStyle: TextStyle(color: myColors.textColor),
                  suggestionStyle:  TextStyle( color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                const SizedBox(
                  height: 40,
                ),
                SearchField<myData<BaseCategory>>(
                  hint: 'Düzey 3 Seçiniz',
                  suggestions:  duzey3.data == null ? [] : duzey3.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(e.duzey3.toString(),
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
                                          color: myColors.textColor, fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
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
                  searchStyle: TextStyle(color: myColors.textColor),
                  suggestionStyle: TextStyle(color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                const SizedBox(
                  height: 40,
                ),
                SearchField<myData<BaseCategory>>(
                  hint: 'Düzey 4 Seçiniz',
                  suggestions:  duzey4.data == null ? [] : duzey4.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(e.duzey4.toString(),
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
                                          color: myColors.textColor, fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
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
                  searchStyle: TextStyle( color: myColors.textColor),
                  suggestionStyle: TextStyle( color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                const SizedBox(
                  height: 40,
                ),
                SearchField<myData<BaseCategory>>(
                  hint: 'Düzey 5 Seçiniz',
                  suggestions:  duzey5.data == null ? [] : duzey5.data
                      ?.map(
                        (e) =>
                        SearchFieldListItem<myData<BaseCategory>>(e.duzey5.toString(),
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
                                          color: myColors.textColor, fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                ),
                              ],
                            ),
                            key: Key(e.id.toString())),
                  )
                      .toList() ?? [],
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
                  searchStyle: TextStyle( color: myColors.textColor),
                  suggestionStyle: TextStyle( color: myColors.textColor),
                  // suggestionsDecoration: BoxDecoration(color: Colors.red),
                ),
                SizedBox(height: 20,),
                AnimatedButton( color: myColors.topColor,
                    text: 'Seç',pressEvent: (){

                  _isButtonDisabled ==true ? null :
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TifKategoriUrunSecimi(islemTuru: this.widget.islemTuru.toString(),
                    islemAdi: this.widget.islemAdi.toString(),
                    islemAciklamasi:
                    this.widget.islemAciklamasi.toString(),
                    anaDepo: int.parse(
                        this.widget.anaDepo.toString()),
                    hedefDepo: int.parse(
                        this.widget.hedefDepo.toString()),
                    islemTarihi:
                    this.widget.islemTarihi.toString(), sonuc: selected,islemId: widget.islemId,)));

                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>TifKategoriUrunSecimi(islemTuru: this.widget.islemTuru.toString(),
                  //     islemAdi: this.widget.islemAdi.toString(),
                  //     islemAciklamasi:
                  //     this.widget.islemAciklamasi.toString(),
                  //     anaDepo: int.parse(
                  //         this.widget.anaDepo.toString()),
                  //     hedefDepo: int.parse(
                  //         this.widget.hedefDepo.toString()),
                  //     islemTarihi:
                  //     this.widget.islemTarihi.toString(), sonuc: selected,islemId: widget.islemId,)));
                }),
                // OutlinedButton(
                //   style: OutlinedButton.styleFrom(
                //     backgroundColor: myColors.topColor,
                //     side: BorderSide(
                //         width: 1.0, color: myColors.topColor),
                //   ),
                //   onPressed: () async {
                //     setState(() {});
                //   },
                //   child: GestureDetector(
                //     onTap: () {
                //
                //       _isButtonDisabled ==true ? null :
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>TifKategoriUrunSecimi(islemTuru: this.widget.islemTuru.toString(),
                //           islemAdi: this.widget.islemAdi.toString(),
                //           islemAciklamasi:
                //           this.widget.islemAciklamasi.toString(),
                //           anaDepo: int.parse(
                //               this.widget.anaDepo.toString()),
                //           hedefDepo: int.parse(
                //               this.widget.hedefDepo.toString()),
                //           islemTarihi:
                //           this.widget.islemTarihi.toString(), sonuc: selected,islemId: widget.islemId,)));
                //
                //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>TifKategoriUrunSecimi(islemTuru: this.widget.islemTuru.toString(),
                //       //     islemAdi: this.widget.islemAdi.toString(),
                //       //     islemAciklamasi:
                //       //     this.widget.islemAciklamasi.toString(),
                //       //     anaDepo: int.parse(
                //       //         this.widget.anaDepo.toString()),
                //       //     hedefDepo: int.parse(
                //       //         this.widget.hedefDepo.toString()),
                //       //     islemTarihi:
                //       //     this.widget.islemTarihi.toString(), sonuc: selected,islemId: widget.islemId,)));
                //     },
                //     child: Text("SEÇ",
                //         style: const TextStyle(
                //             color: Colors.white,
                //             fontSize: 15,
                //             letterSpacing: 2.0)),
                //   ),
                // )
              ])),
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
